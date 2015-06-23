;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname EX-ForWithAndOrSumProductString) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Examples - for with and, or, sum, product, string
(require 2htdp/abstraction)

; the and loops return the last generated value or false
(eq? (for/and ((i 10)) (> (- 9 i) 0)) #false)      
(eq? (for/and ((i 10)) (if (>= i 0) i #false)) 9)

; the or loops return the first non-false value or false
(eq? (for/or ((i 10)) (if (= (- 9 i) 0) i #false)) 9)
(eq? (for/or ((i 10)) (if (< i 0) i #false)) #false)

; sum the results of the iteration
(eq? (for/sum ((c "abc")) (string->int c)) 294)

; multiply the results of the iteration
(eq? (for/product ((c "abc")) (+ (string->int c) 1)) 970200)

; create strings from the generation of 1Strings
(define a (string->int "a"))
(equal? (for/string ((j 10)) (int->string (+ a j))) "abcdefghij")