;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-253-foundAsSpecForFind) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 253. 
; 
; Develop found?, a specification for the find function.
; Use found? to formulate a check-satisfied test for find.

; X [List-of X] -> [Maybe [List-of X]]
; produces the first sublist of l that starts with x, #false otherwise
(check-expect (find "a" '()) #false)
(check-expect (find "a" (list "b" "c" "a" "d" "e"))
              (list "a" "d" "e"))
(check-expect (find "abc" (list "def" "ghi" "abc" "xyz"))
              (list "abc" "xyz"))

(define (find x l)
  (cond
    [(empty? l) #false]
    [else (if (equal? (first l) x) l (find x (rest l)))]))


; X [Maybe [List-of X]] [List-of X] -> Boolean
; is X in lst (original list)
; is X in k (result of 'find')
; is k equal to X and all values after X in l (original list)
(check-expect ((found? "a" '()) (find "a" '()))  #true)
(check-expect ((found? "a" '("b" "c" "a" "d" "e"))
               (find "a" '("b" "c" "a" "d" "e")))    
              #true)
(check-expect ((found? "a"  '("b" "c" "d"))
               (find "a" '("b" "c" "d")))
              #true)
(check-expect ((found? "a"'("b" "c" "a" "d" "e"))
               (find "a" '("a" "e" "d")))
              #false)
              
(define (found? x lst)
  (local (; [List-of X] -> Boolean
          ; returns true if k matches everything in the original
          ; list from x on
          (define (match? m r)
            (if (equal? x (first m))
                (equal? r m)
                (match? (rest m) r))))
  (lambda (k)
    (if (equal? k #false)
      #true                  ; false is a legitmate result of find
      (and (member? x lst)
           (member? x k)
           (match? lst k))))))

; -- check-satisfied tests
;
; NOTE  2015-06-08:
;       as per Matthias Felleisen, a new release of DrRacket is expected shortly
;       after which it will not be necessary to define (name) curried
;       functions before using them in check-satisfied statements

(define t1 (found? "a" '()))
(define t2 (found? "a" (list "b" "c" "a" "d" "e")))
(define t3 (found? "abc" (list "def" "ghi" "abc" "xyz")))

(check-satisfied (find "a" '()) t1)
(check-satisfied (find "a" (list "b" "c" "a" "d" "e")) t2)
(check-satisfied (find "abc" (list "def" "ghi" "abc" "xyz")) t3)
