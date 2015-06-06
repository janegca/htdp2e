;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-242-Lambdas) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 242. 
; 
; Decide which of the following phrases are legal lambda expressions:

(lambda (x y) (x y y))  ; legal - expects a function for the first arg
                        ;   ((lambda (x y) (x y y)) + 2) returns 4

;(lambda () 10)         ; illegal - missing parameter

(lambda (x) x)          ; legal - returns the argument unchanged

(lambda (x y) x)        ; legal - returns the first argument unchanged

;(lambda x 10)          ; illegal - missing parantheses for params

; Explain why they are legal or illegal. If in doubt, experiment in the
; interactions area. 
