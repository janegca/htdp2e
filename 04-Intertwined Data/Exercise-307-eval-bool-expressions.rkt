;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Exercise-301-boolean expressions|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 307. 
;
; Develop a data representation for boolean BSL expressions constructed 
; from #true, #false, and, or, and not. Then design eval-bool-expression.
; The function consumes a representative of boolean BSL expression and 
; computes its value. What is the value of a Boolean expression?

; A BSL-bool-expr is one of:
; - #true
; - #false
; - and
; - or
; - not

; A BSL-bool-vale is a Boolean

(check-expect (eval-bool-expr #true) #true)
(check-expect (eval-bool-expr #false) #false)
(check-expect (eval-bool-expr (and #true #true)) #true)
(check-expect (eval-bool-expr (and #false #true)) #false)
(check-expect (eval-bool-expr (or #false #true)) #true)
(check-expect (eval-bool-expr (or #false #false)) #false)
(check-expect (eval-bool-expr (not #false)) #true)
              
(define (eval-bool-expr boolexpr)
  boolexpr)


