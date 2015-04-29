;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-061-ballf) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 61. 
; An alternative to the nested data representation of balls is a flat 
; representation:
;
;    (define-struct ballf [x y deltax deltay])
;
; Create an instance of ballf that is interpreted in the same way as ball1

(define-struct ball [location velocity])
; A Ball-1d is a structure:  (make-ball Number Number)
; interpretation 1: the position from top and the velocity 
; interpretation 2: the position from left and the velocity 
; program needs to be consistent with chosen interpretation

(define-struct vel [deltax deltay])
; A Vel is a structure: (make-vel Number Number)
; interpretation velocity in number of pixels per clock tick for each direction

(define ball1 (make-ball (make-posn 30 40) (make-vel -10 5)))

(ball-velocity ball1)                ; (make-vel -10 5)
(vel-deltax (ball-velocity ball1))   ; -10

(define-struct ballf [x y deltax deltay])
(define ballf1 (make-ballf 30 40 -10 5))

(ballf-deltax ballf1)
            