;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname SP-RussianDolls) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Sample Problem:
;
; Design the function depth, which measures the number of layers surrounding
; Russian doll. Recall the corresponding data definition:

    (define-struct layer [color doll])
    ; An RD (russian doll) is one of: 
    ; – "wooden doll"
    ; – (make-layer String RD)

(require 2htdp/abstraction)

; RD -> N
; how many dolls are a part of an-rd 
(check-expect (depth (make-layer "red" "wooden doll")) 1)

(define (depth a-doll)
  (match a-doll
    ["wooden doll" 0]
    [(layer c inside) (+ (depth inside) 1)]))

