;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname EX-Sequences) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Example - Sequences

(require 2htdp/abstraction)

; two functions that generate sequences of natural numbers:
; in-naturals and in-range
(check-expect (enumerate.v2 4)
              (list (list 1 0) (list 2 1) (list 3 2) (list 4 3)))

(define (enumerate.v2 l)
  (for/list ((item l) (ith (in-naturals 1)))
    (list ith item)))

; N -> Number 
; add the even numbers between 0 and n (exclusive)
(check-expect (sum-evens 2) 0)
(check-expect (sum-evens 4) 2)

(define (sum-evens n)
  (for/sum ([i (in-range 0 n 2)]) i))
