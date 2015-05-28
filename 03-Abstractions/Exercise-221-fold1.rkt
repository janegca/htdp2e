;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-221-fold1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 221. 
; 
; Design fold1, which is the abstraction of the following two functions:

; [List-of Number] -> Number
; computes the sum of 
; the numbers on l
(check-expect (sum '()) 0)
(check-expect (sum (list 1 2 3)) 6)

(define (sum l)
  (cond
    [(empty? l) 0]
    [else
     (+ (first l)
        (sum (rest l)))]))


; [List-of Number] -> Number
; computes the product of 
; the numbers on l
(check-expect (product '()) 1)
(check-expect (product (list 1 2 3)) 6)

(define (product l)
  (cond
    [(empty? l) 1]
    [else
     (* (first l)
        (product (rest l)))]))

; [Number->Number] -> Number -> [List-of Number] -> Number
; reduces a list of numbers using the given function and
; base
(check-expect (foldl + 0 '()) 0)
(check-expect (foldl + 0 (list 1 2 3)) 6)
(check-expect (foldl * 1 '()) 1)
(check-expect (foldl * 1 (list 1 2 3)) 6)

(define (fold1 f b lon)
  (cond
    [(empty? lon) b]
    [else (f (first lon) (fold1 f b (rest lon)))]))