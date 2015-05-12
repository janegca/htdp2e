;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-132-NEListHowManyFn) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 132. 
; Design how-many for NEList-of-temperatures. Doing so completes average, 
; so ensure that average passes all of its tests, too.

; NEList-of-temperatures -> Number
; computes the average temperature 
(check-expect (average (cons 1 (cons 2 (cons 3 '())))) 2) 
(check-expect (average (cons 1 '())) 1)

(define (average anelot) 
  (/ (sum anelot)   
     (how-many anelot)))

; NEList-of-temperatures -> Number
; compute the sum of a non-empty list of temperatures
(check-expect (sum (cons 1 (cons 2 (cons 3 '())))) 6)

(define (sum anelot) 
  (cond    [(empty? (rest anelot)) (first anelot)]  
           [(cons? (rest anelot)) (+ (first anelot) (sum (rest anelot)))]))

; NEList-of-temperatures -> Number
; count the number of values in a non-empty list of temeperatures
(check-expect (how-many (cons 1 (cons 2 (cons 3 '())))) 3)

(define (how-many anelot)
  (cond [(empty? (rest anelot)) 1]
        [(cons? (rest anelot))
         (+ 1 (how-many (rest anelot)))]))

                




