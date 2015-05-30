;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-231-sorts) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 231. 
; 
; The sort> function consumes a list of numbers and produces a sorted version:

    ; Lon -> Lon
    ; constructs a list from the items in l in descending order
    (define (sort> l0)
      (local (; Lon -> Lon
              (define (sort l)
                (cond
                  [(empty? l) '()]
                  [else (insert (first l) (sort (rest l)))]))
              
              ; Number Lon -> Lon 
              (define (insert an l)
                (cond
                  [(empty? l) (list an)]
                  [else
                   (cond
                     [(> an (first l)) (cons an l)]
                     [else (cons (first l) (insert an (rest l)))])])))
        ; - IN -
        (sort l0)))

; Create a test suite for sort>.
;
; Design the function sort-<, which sorts lists of numbers in ascending order.
;
; Create sort-a, which abstracts sort> and sort-<. It consumes the comparison
; operation in addition to the list of numbers. Define versions sort> and 
; sort-< in terms of sort-a.
;
; Use sort-a to define a function that sorts a list of strings by their 
; lengths, both in descending and ascending order.

; Later we will introduce several different ways to sort lists of numbers, all 
; of them faster than sort-a. If you then change sort-a, all uses of sort-a
; will benefit. 

; -- Example lists from Exercise 211
(define t1
  (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))

(define t2 
  (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25))

; 1. Create a test suite for sort>
(check-expect (sort> '()) '())
(check-expect (sort> (list 1 2 3)) (list 3 2 1))
(check-expect (sort> (list 3 1 4 2)) (list 4 3 2 1))

; 2. Create a function sort-<

; [List-of Number] -> [List-of Number]
; constructs from the items in lon, putting them in ascending order
(check-expect (sort-< '()) '())
(check-expect (sort-< (list 3 2 1)) (list 1 2 3))
(check-expect (sort-< (list 3 1 4 2)) (list 1 2 3 4))

(define (sort-< lon)
      (local (; Lon -> Lon
              (define (sort l)
                (cond
                  [(empty? l) '()]
                  [else (insert (first l) (sort (rest l)))]))
              
              ; Number Lon -> Lon 
              (define (insert an l)
                (cond
                  [(empty? l) (list an)]
                  [else
                   (cond
                     [(< an (first l)) (cons an l)]
                     [else (cons (first l) (insert an (rest l)))])])))
        ; - IN -
        (sort lon)))
  
; 3. Create sort-a which abstracts sort> and sort-<

; [List-of Number] [Number Number -> Boolean] -> [List-of Number]
(check-expect (sort-a '() >) '())
(check-expect (sort-a (list 1 2 3) >) (list 3 2 1))
(check-expect (sort-a (list 3 1 4 2) >) (list 4 3 2 1))
(check-expect (sort-a '() <) '())
(check-expect (sort-a (list 3 2 1) <) (list 1 2 3))
(check-expect (sort-a (list 3 1 4 2) <) (list 1 2 3 4))

(define (sort-a lon cmp)
      (local (; Lon -> Lon
              (define (sort l)
                (cond
                  [(empty? l) '()]
                  [else (insert (first l) (sort (rest l)))]))
              
              ; Number Lon -> Lon 
              (define (insert an l)
                (cond
                  [(empty? l) (list an)]
                  [else
                   (cond
                     [(cmp an (first l)) (cons an l)]
                     [else (cons (first l) (insert an (rest l)))])])))
        ; - IN -
        (sort lon)))
  
; 3.a - define versions of sort> and sort-< in terms of sort-a
(check-expect (sort>.v2 '())            (sort> '()))
(check-expect (sort>.v2 (list 1 2 3))   (sort> (list 1 2 3)))
(check-expect (sort>.v2 (list 1 3 4 2)) (sort> (list 1 3 4 2)))
                         
(define (sort>.v2 lon)
  (sort-a lon >))

(check-expect (sort-<.v2 '())            (sort-< '()))
(check-expect (sort-<.v2 (list 3 2 1))   (sort-< (list 3 2 1)))
(check-expect (sort-<.v2 (list 4 2 1 3)) (sort-< (list 4 2 1 3)))

(define (sort-<.v2 lon)
  (sort-a lon <))

; 4. Use sort-a to define a function that sorts a list of strings
;    by their lengths, both ascending and descending

; [List-of String] [X X -> Boolean] -> [List-of String]
; given a list of strings and a comparison operator,
; sort the list

(check-expect (sort-los (list "a" "abc" "bc") <)
              (list "a" "bc" "abc"))
(check-expect (sort-los (list "a" "abc" "bc") >)
              (list "abc" "bc" "a"))

(define (sort-los los cmp)
  (local ( (define (cmp-lengths a b)
             (cmp (string-length a) (string-length b)))           )
    ; - IN -
    (sort-a los cmp-lengths)))
