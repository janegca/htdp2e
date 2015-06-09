;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-257-distance-between) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 257.
;
; Design the function distance-between. It consumes two numbers and a 
; Posn: x, y, and p. The function computes the distance between the points
; (x, y) and p.

; Number Number Posn -> Number
; returns the Cartesian distance between a point at the cooordinates
; x and y and a given position (p)
(check-expect (distance-between 0 0 (make-posn 0 0)) 0)
(check-expect (distance-between 0 0 (make-posn 3 4)) 5)

(define (distance-between x y p)
  (sqrt (+ (sqr (- (posn-x p) x))
           (sqr (- (posn-y p) y)))))

