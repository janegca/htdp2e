;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-310-numeric) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 315.
; 
; Design the function numeric?, which determines whether a BSL-var-expr is 
; also a BSL-expr. Here we assume that your solution to exercise 309 is the
; definition for BSL-var-expr without the line for Symbol.
;
; NOTE: i.e. check that no symbols are in the expression

; A BSL-expr is one of: 
; – Number
; – (make-add BSL-expr BSL-expr)
; – (make-mul BSL-expr BSL-expr

; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

; -- Structures
(define-struct add [left right])
(define-struct mul [left right])

; [Maybe BSL-var-expr] -> Boolean
; true if the expression has no symbols (variables)
(check-expect (numeric? 3) #true)
(check-expect (numeric? 'x) #false)
(check-expect (numeric? (make-add 5 3))  #true)
(check-expect (numeric? (make-add 'x 3)) #false)
(check-expect (numeric? (make-mul 5 3))  #true)
(check-expect (numeric? (make-mul 'x 3)) #false)

(define (numeric? e)
  (cond [(symbol? e) #false]
        [(number? e) #true]
        [(add? e) (and (numeric? (add-left e))
                       (numeric? (add-right e)))]
        [(mul? e) (and (numeric? (mul-left e))
                       (numeric? (mul-right e)))]))
