;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 1902-Examples-DefineAndLambda) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; 19.02 - Examples - Define and Lambda

; define and lambda
(define (f-plain x)  ; the plain version 
  (expt 10 x))

(define f-lambda ; the lambda version 
  (lambda (x)
     (expt 10 x)))

(equal? (f-plain 2) (f-lambda 2))

; Number -> Boolean
(define (compare x)
  (= (f-plain x) (f-lambda x)))

(compare (random 100000))

