;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-411-gcd-structural) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 411.
;
; Exercise 410 means that the design for gcd-structural calls for some
; planning and a design by composition approach.
;
; The very explanation of “greatest common denominator” suggests a two-stage
; approach. First design a function that can compute the listIdeally, you
; should use sets not lists. of divisors of a natural number. Second, design
; a function that picks the largest common number in the list of divisors of
; n and the list of divisors of m. The overall function would look like those
; shown below. ; Before you design largest-common explain why divisors
; consumes two numbers and why it consumes smaller in both cases.

; N[>=1] N[>=1] -> N
; computes the largest common divisor of two numbers
(check-expect (gcd-structural 18 24) 6)

(define (gcd-structural smaller larger)
  (largest-common (divisors smaller smaller) (divisors smaller larger)))

; N[>= 1] N[>= 1] -> [List-of N]
; computes the list of divisors of l smaller or equal to k
(check-expect (divisors 18 18) '(18 9 6 3 2 1))
(check-expect (divisors 24 24) '(24 12 8 6 4 3 2 1))

(define (divisors k l)
  (cond [(eq? 0 k) '()]
        [(eq? 0 (remainder l k))
         (cons k (divisors (- k 1) l))]
        [else (divisors (- k 1) l)]))

; [List-of N] [List-of N] -> N
; finds the largest number common to both k and l
(check-expect (largest-common '(18 9 6 3 2 1) '(24 12 8 6 4 3 2 1)) 6)

(define (largest-common k* l*)
  (local ((define k (first k*))
          (define l (first l*)))
  (cond [(eq? k l) k]
        [(< k l) (largest-common k* (rest l*))]
        [else (largest-common (rest k*) l*)])))
