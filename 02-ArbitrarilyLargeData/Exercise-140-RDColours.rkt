;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-140-RDColours) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 140. 
;
; Design the function colors. It consumes a Russian doll and produces a 
; string of all colors, separate by a comma and a space. Thus our example 
; should produce: "yellow, green, red"

(define-struct layer [color doll])

; An RD (russian doll) is one of: 
; – String  (colour of inner-most doll)
; – (make-layer String RD)


; RD -> Number
; a string represeing all the colors of all the dolls in an RD
(check-expect (colors "red") "red")
(check-expect (colors (make-layer "yellow" (make-layer "green" "red"))) 
              "yellow, green, red")

(define (colors an-rd) 
  (cond    [(string? an-rd) an-rd]  
           [(layer? an-rd) (string-append (layer-color an-rd) ", "
                                          (colors (layer-doll an-rd)))]))


