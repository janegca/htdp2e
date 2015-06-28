;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-377-underflow) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 377.
;
; ISL+ uses #i0.0 to approximate underflow. Determine the smallest integer n
; such that (expt #i10.0 n) is still an inexact ISL+ number and (expt #i10.
; (- n 1)) is approximated with 0. Hint Use a function to compute n. Consider
; abstracting over this function and the solution of exercise 376.

(check-expect (compute 0) -323)  ; result on a 64-bit system

(define (compute n)
  (if (equal? #i0.0 (expt #i10.0 (- n 1)))
      n
      (compute (- n 1))))

(expt #i10.0 -323)   ; #i9.8813129168249e-324
(expt #i10.0 -324)   ; #i0.0

