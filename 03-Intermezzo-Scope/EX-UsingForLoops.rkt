;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname EX-UsingForLoops) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Examples for/loops

; this package is available with DrRacket v6.2, released June 20th, 2015
(require 2htdp/abstraction)

; building a list:  (list 0 1 2 3 4 5 6 7 8 9)
(define ex1 (for/list ((i 10)) i)) 
(define ex1-bl (build-list 10 (lambda (i) i)))
(equal? ex1 ex1-bl)

; building an array: (list (list 0 'a) (list 1 'b))
(define ex2 (for/list ((i 2) (j '(a b))) (list i j)))
(define ex2-bl
  (local ((define i-s (build-list 2 (lambda (i) i)))
          (define j-s '(a b)))
    (map list i-s j-s)))
(equal? ex2 ex2-bl)
