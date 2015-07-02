;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 3102-SP-RockerAcceleration) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 31.2 - Sample Problem - Binary Search - Rocket Acceleration
;
; Sample Problem:
;     A rocket is flying at the constant speed of v miles per hour on a
;     straight line towards some target, d0 miles away. It then accelerates
;     at the rate of a miles per hour squared for t hours. When will it hit
;     its target?

; distance covered is:
;    d(t) = (v * t + 1/2 * a * t^2)
;
; we want to find the time, t0, when the rocket hits its target
;   d0 = (v * t0 + 1/2 * a * t0^2)
;
; the above is a 'quadratic function' which we will solve using the
; Intermediate Value Theorem (IVT) which says:
;    that a continuous function f has a root in an interval [a,b]
;    if f(a) and f(b) are on the opposite side of the x axis.
;
; ie the following must hold
;        (or (<= (f a) 0 (f b))
;            (<= (f b) 0 (f a)))
;
; our function, find-root, needs to look for an interval such that
; (- a b) is 0 or within some tolerable range
;

(define TOLERANCE 0.5)

; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R TOLERANCE)]
; assume f is continuous 
; assume (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divide interval in half, the root is in one of the two
; halves, pick according to assumption 
(define (find-root f left right)
  (cond
    [(<= (- right left) TOLERANCE) left]
    [else
      (local ((define mid (/ (+ left right) 2))
              (define f@mid (f mid)))
        (cond
          [(or (<= (f left) 0 f@mid) (<= f@mid 0 (f left)))
           (find-root f left mid)]
          [(or (<= f@mid 0 (f right)) (<= (f right) 0 f@mid))
           (find-root f mid right)]))]))



