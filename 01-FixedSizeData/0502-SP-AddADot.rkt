;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0502-SP-AddADot) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 05.02 - Sample Problem - AddADot
;
; Your team is designing a program that keeps track of the last mouse click 
; on a 100 x 100 canvas. Together you chose Posn as the data representation 
; for the x and y coordinates of the mouse click. Design a function that 
; consumes a mouse click and a 100 x 100 scene and adds a circular red spot 
; to the scene where the click occurred.

; visual constants
(define MTS (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

; Posn Image -> Image
; adds a red spot to s at p
(check-expect (scene+dot (make-posn 10 20) MTS)              
              (place-image DOT 10 20 MTS))
(check-expect (scene+dot (make-posn 88 73) MTS)             
              (place-image DOT 88 73 MTS))

(define (scene+dot p s)  
  (place-image DOT (posn-x p) (posn-y p) s))

; usage example
(scene+dot (make-posn 50 50) MTS)


