;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-094-Coordiante) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 94. Some program contains the following data definition:
;
    ; A Coordinate is one of: 
    ; – a negative number 
    ;    interpretation: a point on the Y axis, distance from top
    ; – a positive number 
    ;    interpretation: a point on the X axis, distance from left
    ; – a Posn
    ;    interpretation: a point in a scene, usual interpretation

; Make up at least two data examples per clause in the data definition. 
; For each of the examples, explain its meaning with a sketch of a canvas. 

; Examples
(define nn1 -10)
(define nn2 -2)

(define pn1 10)
(define pn2 30)

(define pos1 (make-posn -1 10))
(define pos2 (make-posn 10 -3))
