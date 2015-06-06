;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-244-CreatingLambdaFns) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 244. 
; 
; Write down a lambda expression that
;
; 1. consumes a number and decides whether it is less than 10;
;
; 2. consumes two numbers, multiplies them, and turns the result into a string;
;
; 3. consumes two inventory records and compares them by price;
;
; 4. consumes a natural number and produces 0 if it is even and 1 if it is 
;    odd; and
;
; 5. consumes an Posn p together with a rectangular Image and adds a red 
;    3-pixel dot to the image at p.
;
; Demonstrate how to use these functions in the interactions area. 


((lambda (x) (< x 10)) 2)
((lambda (x y) (number->string (* x y))) 2 3)

(define-struct ir [name price])
((lambda (f a b) (f (ir-price a) (ir-price b)))
 < (make-ir "a" 10) (make-ir "b" 20))

((lambda (x) (if (even? x) 0 1)) 3)

((lambda (p img) (place-image (circle 3 "solid" "red")
                              (posn-x p)
                              (posn-y p)
                              img))
 (make-posn 50 50) (rectangle 100 100 "solid" "blue"))

