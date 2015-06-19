;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-315-BSL-fun-expr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 320.
; 
; Extend the data representation of Interpreting Variables to include the 
; application of a programmer-defined function. Recall that a function
; application consists of two pieces: a name and an expression. The former
; is the name of the function that is applied; the latter is the argument.
;
; We refer to this newly defined class of data with BSL-fun-expr.

; ANS:

; A BSL-fun-expr is one of: 
; – Number
; – Symbol 
; - (make-fun name         BSL-fun-expr)
; – (make-add BSL-fun-expr BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)

; -- Structures
(define-struct fun [name arg])
; Fun is a structure: (make-fun Symbol  BSL-fun-expr)

(define-struct add [left right])
; Add is a structure: (make-add BSL-fun-expr BSL-fun-expr)

(define-struct mul [left right])
; Mul is a structure: (make-mul BSL-fun-expr BSL-fun-expr)

; Use your data definition to represent the following expressions:
;
;    (k (+ 1 1))
        (make-fun 'k (make-add 1 1))  
;    (* 5 (k (+ 1 1)))
        (make-mul 5 (make-fun 'k (make-add 1 1)))
;    (* (i 5) (k (+ 1 1)))
        (make-mul (make-fun 'i 5) (make-fun 'k (make-add 1 1)))

