;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-141-InnermostRD) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 141.
; 
; Design the function inner, which consumes an RD and produces the 
; (color of the) innermost doll. 

(define-struct layer [color doll])

; An RD (russian doll) is one of: 
; – String  (colour of inner-most doll)
; – (make-layer String RD)


; RD -> Number
; a string represeing all the colors of all the dolls in an RD
(check-expect (inner "red") "red")
(check-expect (inner (make-layer "yellow" (make-layer "green" "red"))) 
              "red")

(define (inner an-rd) 
  (cond    [(string? an-rd) an-rd]  
           [(layer? an-rd) (inner (layer-doll an-rd))]))


