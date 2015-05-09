;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-101-Predicates) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 101. 
; Design predicates for the following data definitions from the preceding 
; section: SIGS, Coordinate (exercise 94), and VAnimal.

; A SIGS is one of: 
; – (make-aim UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation represents the state of the space invader game

(define-struct tank [loc vel])

; Any -> Boolean
; returns true if s is a SIGS, otherwise, returns false
(check-expect (sigs-or-not? (make-posn 3 10)) true)
(check-expect (sigs-or-not? (make-tank 50 1)) true)
(check-expect  (sigs-or-not? "hello") false)

(define (sigs-or-not? s)
  (cond
    [(posn? s) true]
    [(tank? s) true]
    [else      false]))

; A Coordinate is one of: 
; – a negative number 
;    interpretation a point on the Y axis, distance from top
; – a positive number 
;    interpretation a point on the X axis, distance from left
; – a Posn
;    interpretation a point in a scene, usual interpretation

; Any -> Boolean
; returns true if c is a coordinate, otherwise, returns false
(check-expect (coord-or-not? 9) true)
(check-expect (coord-or-not? -1) true)
(check-expect (coord-or-not? "a") false)

(define (coord-or-not? c)
  (cond
    [(number? c) true]
    [(posn?   c) true]
    [else false]))

; A VAnimal is either
; – a VCat
; – a VCham

(define-struct vcat [xpos hnum dir])
(define-struct vcham [xpos hnum dir colour])

; Any -> Boolean
; returns true of v is a VAnimal, otherwise, returns false
(check-expect (vanimal-or-not? (make-vcat 3 100 1)) true)
(check-expect (vanimal-or-not? (make-vcham 10 50 1 "red")) true)
(check-expect (vanimal-or-not? "cat") false)

(define (vanimal-or-not? v)
  (cond
    [(vcat?  v) true]
    [(vcham? v) true]
    [else false]))