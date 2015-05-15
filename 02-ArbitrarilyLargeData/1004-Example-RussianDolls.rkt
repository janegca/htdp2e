;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 10.04-Example-RussianDolls) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 10.04 - Example - Russian Dolls

(define-struct layer [color doll])

; An RD (russian doll) is one of: 
; – String  (colour of inner-most doll)
; – (make-layer String RD)


; RD -> Number
; how many dolls are a part of an-rd 
(check-expect (depth "red") 1)
(check-expect (depth (make-layer "yellow" (make-layer "green" "red"))) 3)

(define (depth an-rd) 
  (cond    [(string? an-rd) 1]  
           [(layer? an-rd) (+ (depth (layer-doll an-rd)) 1)]))


