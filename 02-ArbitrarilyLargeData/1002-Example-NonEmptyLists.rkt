;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 10.02-Example-NonEmptyLists) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 10.02 - Example - Non-empty List

; A NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of measured temperatures 

; NEList-of-temperatures -> Number
; computes the sum of the given temperatures 

(check-expect (sum (cons 1 (cons 2 (cons 3 '())))) 6)

(define (sum anelot) 
  (cond    [(empty? (rest anelot)) (first anelot)]  
           [(cons? (rest anelot)) (+ (first anelot) (sum (rest anelot)))]))




