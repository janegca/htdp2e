;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-376-overflow) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 376.
;
; ISL+ uses +inf.0 to deal with overflow. Determine the integer n such that
; (expt #i10.0 n) is an inexact number while (expt #i10. (+ n 1)) is
; approximated with +inf.0. Hint Design a function to compute n.


(check-expect (compute 0) 308)   ; result on a 64-bit system

(define (compute n)
  (if (equal? +inf.0 (expt #i10.0 (+ n 1)))
      n
      (compute (+ n 1))))

(expt #i10.0 308)  ; #i1e+308
(expt #i10.0 309)  ; #i+inf.0
