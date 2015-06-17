;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-306-eval-expression) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 306. 
; 
; Design eval-expression. The function consumes a representation of a BSL 
; expression (according to exercise 304) and computes its value.

; A BSL-expr is one of:
; - Number
; - Op
;
; An Op (Operator) is one of:
; - Add
; - Mul
;

(define-struct add [left right])
; Add is a structure: (make-add BSL-expr BSL-expr)

(define-struct mul [left right])
; Mul is a structure: (make-mul BSL-expr BSL-expr)

; BSL-value is a Number

; BSL-expr -> BSL-value
(check-expect (eval-expr 3) 3)
(check-expect (eval-expr (make-add 1 1)) 2)
(check-expect (eval-expr (make-mul 3 10)) 30)
(check-expect (eval-expr (make-add (make-mul 1 1) 10)) 11)
(check-error  (eval-expr 'x))

(define (eval-expr bexpr)
  (cond [(number? bexpr) bexpr]
        [(add?    bexpr) 
         (+ (eval-expr (add-left bexpr)) (eval-expr (add-right bexpr)))]
        [(mul?    bexpr)
         (* (eval-expr (mul-left bexpr)) (eval-expr (mul-right bexpr)))]))


        