;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-251-my-map-with-lambda) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 251
;
; Re-write Exercise 238 using lambdas vs local functions

(check-expect (my-map add1 '()) '())
(check-expect (my-map add1 (list 1 2 3)) (map add1 (list 1 2 3)))

(define (my-map f lst)
    (foldr (lambda (fst rst) (cons (f fst) rst))
           '() 
           lst))

