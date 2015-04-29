;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0403-SP-EnumerationAndKeyEvents) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 04.03 Sample Problem
; Enumeration and KeyEvents
; When an enumeration is large, best to isolate only the values
; you actually need.

; Position is a Number. 
; interpretation distance between the left margin and the ball  

; Position KeyEvent -> Position
; computes the next location of the ball 
(check-expect (keh 13 "left") 8)
(check-expect (keh 13 "right") 18)
(check-expect (keh 13 "a") 13)

(define (keh p k)
  (cond
    [(string=? "left"  k) (- p 5)]
    [(string=? "right" k) (+ p 5)]
    [else p]))