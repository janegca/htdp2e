;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-252-sorted) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 252. 
; 
; Design the function sorted?, which comes with the following signature and 
; purpose statement; the wish list even includes examples.

; [X X -> Boolean] [NEList-of X] -> Boolean 
; determine whether l is sorted according to cmp

(check-expect (sorted? < '(1 2 3)) #true)
(check-expect (sorted? < '(2 1 3)) #false)

(define (sorted? cmp l)
  (cond [(empty? (rest l)) #true]
        [(cmp (first l) (second l))
         (sorted? cmp (rest l))]
        [else #false]))


