;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0502-SP-UFOVelocity) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 05.02 - Sample Problem - UFO Velocity
;
; Your team is designing a game program that keeps track of an object that
; moves across the canvas at changing speed. The chosen data representation 
; requires two data definitions: velocity and ufo.
; Design the function move1, which moves some given UFO for one clock tick.

(define-struct velocity [dx dy])
; A Velocity is a structure: (make-velocity Number Number)
; interpretation: (make-velocity a b) means that the object moves a steps
; along the horizontal and b steps along the vertical per tick  

(define-struct ufo [loc vel])
; A UFO is a structure: (make-ufo Posn Velocity)
; interpretation: (make-ufo p v) is at location p moving at velocity v 

; examples
(define v1 (make-velocity 8 -3))
(define v2 (make-velocity -5 -3))

(define p1 (make-posn 22 80))
(define p2 (make-posn 30 77))

(define u1 (make-ufo p1 v1))
(define u2 (make-ufo p1 v2))
(define u3 (make-ufo p2 v1))
(define u4 (make-ufo p2 v2))






