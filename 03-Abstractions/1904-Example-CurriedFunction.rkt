;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 1904-Example-CurriedFunction) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; 19.04 Example - Curried Function

; NOTE: cannot get the check-satisfied code to work with curried functions
;       error "check-satisifed: expects named function in second position"
;       acutally 'defining' the curried functions appears to correct the problem
;       although not comletely; still having trouble with the check using
;       'sorted-variant-of'
;
;
; sort-cmp routine from Figure 59
; [List-of Number] [Number Number -> Boolean] -> [List-of Number]

(define (sort-cmp alon0 cmp)
  (local (; [List-of Number] -> [List-of Number]
          ; produces a variant of alon sorted by cmp
          (define (isort alon)
            (cond
              [(empty? alon) '()]
              [else (insert (first alon) (isort (rest alon)))]))
 
          ; Number [List-of Number] -> [List-of Number]
          ; inserts n into the sorted list of numbers alon 
          (define (insert n alon)
            (cond
              [(empty? alon) (cons n '())]
              [else (if (cmp n (first alon))
                        (cons n alon)
                        (cons (first alon)
                              (insert n (rest alon))))])))
    (isort alon0)))

; From Figure 62

; [X X -> Boolean] -> [[List-of X] -> Boolean]
; is the given list l0 sorted according to cmp
(check-expect [(sorted string<?) '("a" "b" "c")] #true)
(check-expect [(sorted <) '(1 2 3 4 5 6)] #true)

(define (sorted cmp)
  (lambda (l0)
    (local (; [NEList-of X] -> Boolean 
            ; is l sorted according to cmp
            (define (sorted/l l)
              (cond
                [(empty? (rest l)) #true]
                [else (and (cmp (first l) (second l))
                           (sorted/l (rest l)))])))
      (if (empty? l0) #true (sorted/l l0)))))

; -- example of calling a curried function,
((sorted < ) '(1 2 3))
((sorted <)  '(2 1 3))

; -- check-satisfied using sorted, wouldn't work until the curried
;    functions were given names (defined)
(define s1 (sorted string<?))
(define s2 (sorted <))

;(check-satisfied (sort-cmp '("a" "c" "b") string<?) (sorted string<?))
(check-satisfied (sort-cmp '("a" "c" "b") string<?) s1)

;(check-satisfied (sort-cmp '(2 1 3 4 6 5) <) (sorted <))
(check-satisfied (sort-cmp '(2 1 3 4 6 5) <) s2)


; the local function (sorted/l l) could be replaced with 
; sorted? from Exercise 252

; -- Ex 252 function
(define (sorted? cmp l)
  (cond [(empty? (rest l)) #true]
        [(cmp (first l) (second l))
         (sorted? cmp (rest l))]
        [else #false]))

(check-expect [(sorted.v1 string<?) '("a" "b" "c")] #true)
(check-expect [(sorted.v1 <) '(1 2 3 4 5 6)] #true)

(define (sorted.v1 cmp)
  (lambda (l0)
      (if (empty? l0) #true 
          (sorted? cmp l0))))  ; cmp is visible, same as it is within a
                               ; local definition

((sorted.v1 <) '(1 2 3))
((sorted.v1 <) '(2 1 3))

; function specifications example for sorted

; [List-of X] [X X -> Boolean] -> [ [List-of X] -> Boolean]
; is l0 sorted according to cmp
; does l0 contain all the items in k
; does k contain all the items in l0
(check-expect ((sorted-variant-of '(1 2 3) <)   '(1 2 3)) #true)
(check-expect ((sorted-variant-of '(1 2 3 4) <) '(1 2 3)) #false)

(define (sorted-variant-of k cmp)
  (lambda (l0)
    (and (sorted?   cmp l0)
         (contains? l0 k)
         (contains? k l0))))

; [Listof X] [Listof X] -> Boolean 
; are all items in list l members of list k

(check-expect (contains? '(1 2 3)   '(2 1 4 3)) #true)
(check-expect (contains? '(1 2 3 4) '(2 1 3))   #false)

(define (contains? l k)
  (andmap (lambda (item-in-l) (member? item-in-l k)) l))

; -- this first version of 'sorted-variant-of' will pass tests
;    that are essentially incorrect

; [List-of Number] -> [List-of Number] 
; produces a sorted version of l
(define cf (sorted-variant-of '(1 2 3) <))

;(check-expect    (sort-cmp/worse '(1 2 3)) '(1 2 3))
(check-satisfied (sort-cmp/worse '(1 2 3)) cf)

(define (sort-cmp/worse l)
  (local ((define sorted-version (sort-cmp l <)))
    (cons (- (first sorted-version) 1) sorted-version)))

; -- testing a sort using the specification
(define (generate-a-list-of-numbers n)
  (build-list n (lambda (i) (random 10))))

(define a-list (generate-a-list-of-numbers 500))

;(check-satisfied (sort-cmp a-list <) (sorted-variant-of a-list <))
(define sv1 (sorted-variant-of a-list <))
(check-satisfied (sort-cmp a-list <) sv1)  ; fails nearly every time



