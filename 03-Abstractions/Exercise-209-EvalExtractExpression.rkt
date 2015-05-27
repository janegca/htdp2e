;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-209-EvalExtractExpression) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 209. Evaluate the expression
;
;    (extract < (cons 8 (cons 6 (cons 4 '()))) 5)
;
; by hand. Show the new steps, rely on prior calculations where possible. 

;    (extract < (cons 8 (cons 6 (cons 4 '()))) 5)
; == (extract < (cons 6 (cons 4 '())) 5)
; == (extract < (cons 4 '()) 5)
; == (cons 4 '())


