;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-152-SumPosn-x) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 152. 
; 
; Design the function sum, which consumes a list of Posns and produces the 
; sum of all of its x coordinates.

; List-of-Posns -> Number
; sum the values of the x-coordinates in a list of Posn's
(check-expect (sum '()) 0)
(check-expect (sum (cons (make-posn 1 2) '())) 1)
(check-expect (sum (cons (make-posn 1 2)(cons (make-posn 2 3) '()))) 3)

(define (sum lop)
  (cond [(empty? lop) 0]
        [else (+ (posn-x (first lop)) (sum (rest lop)))]))
