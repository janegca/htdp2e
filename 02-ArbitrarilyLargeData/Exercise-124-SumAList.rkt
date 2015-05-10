;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-124-SumAList) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 124. 
; Here is a data definition for representing amounts of money:

    ; A List-of-amounts is one of: 
    ; – '()
    ; – (cons PositiveNumber List-of-amounts)
    ; interpretation a List-of-amounts represents some amounts of money 

; Create some examples to make sure you understand the data definition. 
; Also add an arrow for the self-reference.
;
; Design the function sum, which consumes a List-of-amounts and computes 
; the sum of the amounts. 

; List-of-Money -> Number
; returns the sum of a list of monetary values
(check-expect (sum (cons 10 (cons 20 (cons 30 '())))) 60)
(check-expect (sum (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 '())))))) 15)
(check-expect (sum (cons 0 '())) 0)
(check-expect (sum '()) 0)

(define (sum a-list-of-money)
  (cond
    [(empty? a-list-of-money) 0]
    [(cons?  a-list-of-money)
     (+ (first a-list-of-money) (sum (rest a-list-of-money)))]))



     