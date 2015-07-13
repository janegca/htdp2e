;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 3202-SP-NumericIntegration) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 32.02 - Sample Problem - Numeric Integration

(define EPSILON 0.1)

(define (constant x) 20)
(define (linear x) (* 2 x))
(define (square x) (* 3 (sqr x)))

; [Number -> Number] Number Number -> Number
; computes the area under the graph of f between a and b
; assume (< a b) holds

(check-within (integrate constant 12 22) 200 EPSILON)
(check-within (integrate linear 0 10) 100 EPSILON)
(check-within (integrate square 0 10) (- (expt 10 3) (expt 0 3)) EPSILON)

(define (integrate f a b)
  #i0.0)




