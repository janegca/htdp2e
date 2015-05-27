;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-207-AbstractionExercise) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 207.
;
; Create test suites for the two functions add1 and plus5 (given below)
; then abstract over them. 
;
; Define the above two functions in terms of the abstraction as one-liners 
; and use the existing test suites to confirm that the revised definitions 
; work properly. Finally, design a function that subtracts 2 from each number
; on a given list.

; Lon -> Lon
; add 1 to each number on l
(check-expect (add1* '()) '())
(check-expect (add1* (list 1 2 3)) (list 2 3 4))

(define (add1* l)
  (cond
    [(empty? l) '()]
    [else
     (cons (add1 (first l))
           (add1* (rest l)))]))

; Lon -> Lon
; adds 5 to each number on l
(check-expect (plus5 '()) '())
(check-expect (plus5 (list 1 2 3)) (list 6 7 8))

(define (plus5 l)
  (cond
    [(empty? l) '()]
    [else
     (cons (+ (first l) 5)
           (plus5 (rest l)))]))

; Lon -> Lon
; add n to each number in lon
(check-expect (addN 1 (list 1 2 3)) (list 2 3 4))
(check-expect (addN 5 (list 1 2 3)) (list 6 7 8))

(define (addN n lon)
  (cond [(empty? lon) '()]
        [else (cons (+ n (first lon))
                    (addN n (rest lon)))]))

; Lon -> Lon
(check-expect (add-one '()) (add1* '()))
(check-expect (add-one (list 1 2 3)) (add1* (list 1 2 3)))
 
(define (add-one lon)
  (addN 1 lon))

; Lon -> Lon
(check-expect (add-five '()) (plus5 '()))
(check-expect (add-five (list 1 2 3)) (plus5 (list 1 2 3)))

(define (add-five lon)
  (addN 5 lon))

; Lon -> Lon
(check-expect (sub2 '()) '())
(check-expect (sub2 (list 2 4 6)) (list 0 2 4))

(define (sub2 lon)
  (addN -2 lon))