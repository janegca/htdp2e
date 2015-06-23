;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-273-convert-euro) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 273.
;
; Use loops to define convert-euro, a function that converts a list of US$
; amounts into a list of € amounts based on an exchange rate of €1.08 per US$.
; Compare with exercise 241 [232]

(require 2htdp/abstraction)

; [List-of Number] -> [List-of Number]
; convert a list of US$ to a list of Euro's using an exchange
; rate of €1.08 per US$.
(check-expect (convert-euro '()) '())
(check-expect (convert-euro (list 1 2 3 4))
              (list 1.08 (* 2 1.08) (* 3 1.08) (* 4 1.08)))

(define (convert-euro lod)
  (for/list ([amt lod]) (* amt 1.08)))
