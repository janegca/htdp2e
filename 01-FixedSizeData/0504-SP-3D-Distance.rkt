;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0504-SP-3D-Distance) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 05.04 - Sample Problem - 3D Distance
;
; Design a function that computes the distance of objects 
; in a 3-dimensional space to the origin of the coordinate system.

(define-struct r3 [x y z])
; R3 is (make-r3 Number Number Number) 

(define ex1 (make-r3  1 2 13))
(define ex2 (make-r3 -1 0  3))

; R3 -> Number 
; determines the distance of p to the origin 
(define (r3-distance-to-0 p)  
  (sqrt (+ (sqr (r3-x p)) 
           (sqr (r3-y p)) 
           (sqr (r3-z p)))))




