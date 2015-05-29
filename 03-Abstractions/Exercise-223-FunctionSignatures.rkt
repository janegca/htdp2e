;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-223-FunctionSignatures) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 223. 
;
; Each of the following signatures describes a collection of functions:

    ; [Number -> Boolean]
    ; [Boolean String -> Boolean]
    ; [Number Number Number -> Number]
    ; [Number -> [List-of Number]]
    ; [[List-of Number] -> Boolean]

; Describe these collections with at least one example from ISL.

; [Number -> Boolean]
; functions that take a parameter of one type and return a value of
; type Boolean
(odd? 1)   ; true

; [Boolean String -> Boolean]
; functions that take two parameters and return a value with the same
; type as the first parameter
(equal? #true "hello")  ; false

; [Number Number Number -> Number]
; functions that take three values of the same type, reducing
; them to one value of the same type
(+ 3 4 5)

; [Number -> [List-of Number]]
; functions that take one parameter, returning a list of items of the same
; type 
(explode "cat")  ; (list "c" "a" "t")

; [[List-of Number] -> Boolean]
; functions that take a list of any type and return a boolean
(null? (list 1 2 3))