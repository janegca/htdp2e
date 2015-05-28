;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-215-OccursFn) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 216. Here is one more parametric data definition:

    ; A [Maybe X] is one of: 
    ; – #false 
    ; – X

; Interpret the following data definitions:
;
;    [Maybe String]
;
;    [Maybe [List-of String]]
;
;    [List-of [Maybe String]]
;
; What does the function signature for 'occurs' mean?
; Design the function.

; String [List-of String] -> [Maybe [List-of String]]
; returns the remainder of the list los if it contains s 
; #false otherwise 
(check-expect (occurs "a" (list "b" "a" "d")) (list "d"))
(check-expect (occurs "a" (list "b" "c" "d")) #f)

(define (occurs s los)
  (cond [(empty? los) #false]
        [(string=? s (first los)) (rest los)]
        [else (occurs s (rest los))]))

