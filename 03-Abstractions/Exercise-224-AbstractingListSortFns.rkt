;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-224-AbstractingFnSigs) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 224. 
;
; Formulate signatures for the following functions:
;
;    sort-n, which consumes a list of numbers and a function that consumes 
;    two numbers (from the list) and produces a Boolean; sort-n produces a 
;    sorted list of numbers.
;
;    sort-s, which consumes a list of strings and a function that consumes 
;    two strings (from the list) and produces a Boolean; sort-s produces a
;    sorted list of strings.
;
; Then abstract over the two signatures, following the above steps.
; Also show that the generalized signature can be instantiated to describe
; the signature of a sort function for lists of IRs. 

; [Lisf-of Number] (Number Number -> Boolean) -> [Sorted-List-of Numbers]
; [List-of String] (String String -> Boolean) -> [Sorted-List-of Strings]

; [List-of X] (X X -> Boolean) -> [Sorted-List-of X]

; [List-of IR] (IR IR -> Boolean) -> [Sorted-List-of IR]
