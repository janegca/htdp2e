;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-421-slope) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 421.
;
; Translate this mathematical formula into the ISL+ function slope, which maps
; function f and a number x to the slope of f at x. Assume that EPSILON is a
; global constant. For your examples, use functions whose exact slope you can
; figure out, say, horizontal lines, linear functions, and perhaps polynomials
; if you know some calculus.

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

    
