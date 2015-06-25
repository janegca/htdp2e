;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-329-Xexpr-v2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 337. 
;
; Eliminate the use of List-of from the data definition Xexpr.v2.

(define-struct element [name attributes content])
; An Xexpr.v2 is 
; – (cons Symbol Xexpr.v2*)
; – (cons Symbol (cons Attribute* Xexpr.v2*))

(define-struct attribute [name value])
; An Attribute is 
;   (cons Symbol (cons String '()))

