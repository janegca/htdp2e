;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-422-root-of-tangent) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 422.
;
; Translate this mathematical formula into the function root-of-tangent,
; which maps function f and a number x to the root of the tangent through
; (x,(f x)). You need to solve exercise 421 first and reuse the solution here.

; from Exercise 421

(define EPSILON 0.001)

(define (f1 x) (+ (* -2 x) 3))
(define (f2 x) 0)

; (Number -> Number) N -> Number
; the slope of x at f
(check-expect (slope f1 -1) -2)
(check-expect (slope f2  3)  0)

(define (slope f x)
  (local ((define x1 (+ x EPSILON))
          (define x2 (- x EPSILON))
          (define y1 (f x1))
          (define y2 (f x2)))
    (/ (- y1 y2) (* 2 EPSILON))))

; code for exercise 422

(define (f3 x) (- (* x x) 3))

; (Number -> Number) Number -> Number
; the root of the tangent for f at x
(check-expect (root-of-tangent f1 -1) 1.5)
(check-within (root-of-tangent f3 1.75) 1.732 EPSILON)

(define (root-of-tangent f x)
  (- x (/ (f x) (slope f x))))

