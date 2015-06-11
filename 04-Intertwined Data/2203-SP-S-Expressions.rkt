;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 2203-SP-S-Expressions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 22.03 - Sample Problem - S-Expressions

; Sample Problem: 
;
; Design the function count, which determines how many times some symbol sy 
; occurs in some S-expression sexp.

; An S-expr (S-expression) is one of: 
; – Atom
; – SL
; An SL (S-list) is one of: 
; – '()
; – (cons S-expr SL)
; An Atom is one of: 
; – Number
; – String
; – Symbol 


