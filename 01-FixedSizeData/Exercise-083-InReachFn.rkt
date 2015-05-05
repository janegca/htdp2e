;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-083-InReachFn) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 84.
;
; A programmer has chosen to represent locations on the Cartesian plane as 
; pairs (x, y) or as single numbers if the point lies on one of the axes: 
; 
; Location is one of:
;   – Posn
;   – Number
; interpretation: Posn are positions on the Cartesian plane,
; Numbers are positions on either the x or the y axis.
;
; Design the function in-reach?, which determines whether a given location’s 
; distance to the origin is strictly less than some constant R.
;
; Recall that the distance of a Cartesian point to the origin is the square
; root of the sum of the squares of its coordinates. For a location on either
; axis, the distance to the origin is the absolute value of the number. 

(define R 20)

; Location -> Boolean
; returns true if the location is with R distance from origin
(check-expect (in-reach? 10)  #true)
(check-expect (in-reach? 30)  #false)
(check-expect (in-reach? -10) #true)
(check-expect (in-reach? -30) #false)

(define (in-reach? loc)
  (cond
    [(number? loc) (<= (abs loc) R)]
    [else (<= (distance loc) R)]))

; Posn -> Number
; returns the cartesian distance of the given position
; from the origin
(check-expect (in-reach? (make-posn   2   2)) #true)
(check-expect (in-reach? (make-posn  30   2)) #false)
(check-expect (in-reach? (make-posn   2  40)) #false)
(check-expect (in-reach? (make-posn   2 -40)) #false)
(check-expect (in-reach? (make-posn  -2   2)) #true)
(check-expect (in-reach? (make-posn -30   2)) #false)
(check-expect (in-reach? (make-posn   0   0)) #true)

(define (distance pos)
  (sqrt (+ (sqr (posn-x pos)) (sqr (posn-y pos)))))

