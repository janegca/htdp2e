;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-011-TypeChecking) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 11
; Create an expression that converts whatever 'in' represents to a number. 
; For a string, it determines how long the string is; for an image, it uses
; the area; for a number, it decrements the number, unless it is already 0 or 
; negative; for #true it uses 10 and for #false 20.

(define in "hello")

(define (doNumber val) (if (<= val 0) in (- val 1)))

(define eval (if (string? in) (string-length in)
                 (if (image? in) (* (image-width in) (image-height in))
                     (if (number? in)(doNumber in) 
                         (if (boolean? in) (if in 10 20) 20)))))
