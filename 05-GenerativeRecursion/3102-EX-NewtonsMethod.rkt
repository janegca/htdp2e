;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 3102-EX-NewtonsMethod) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 31.02 - Example - Newton's Method

(define EPSILON 0.001)

; Number -> Number
(define (poly x)
  (* (- x 2) (- x 4)))

; [Number -> Number] Number -> Number
; finds a number r such that (<= (abs (f r)) EPSILON)
 
(check-within (newton poly 1) 2 EPSILON)
(check-within (newton poly 3.5) 4 EPSILON)
 
(define (newton f r1)
  (cond
    [(<= (abs (f r1)) EPSILON) r1]
    [else (newton f (root-of-tangent f r1))]))


; from exercise 421
(define (slope f x)
  (local ((define x1 (+ x EPSILON))
          (define x2 (- x EPSILON))
          (define y1 (f x1))
          (define y2 (f x2)))
    (/ (- y1 y2) (* 2 EPSILON))))

; from exercise 422
(define (root-of-tangent f x)
  (- x (/ (f x) (slope f x))))

; -- PROBLEMS that can arise:
;   division by zero  -- try (newton poly 3)
;   inexact numbers   -- try (newton poly 2.9999) -- exceedingly long
;   non-termination   -- try (newton poly #i3.0)  -- root produces #i+inf.0
;                                                 -- which is used repeatedly
;                                                 -- as the guess


