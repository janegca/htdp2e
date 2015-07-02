;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-412-poly) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 412.
;
; Consider the following function definition:

; Number -> Number
; computes the root of a binomial
(check-expect (poly 2) 0)
(check-expect (poly 4) 0)

(define (poly x)
  (* (- x 2) (- x 4)))

; Use poly to formulate a check-satisfied test for find-root.
;
; Answer:
;    (check-satisfied (find-root poly 3 6) in-range?)
;
;
; Also use poly to illustrate the root-finding process. Start with the
; interval [3,5] and tabulate the information as follows:
;
; step   left  f(left)  right  f(right)  mid  f(mid)
; ----   ----  ------   -----  --------  ---  ------
; n = 1    3     -1     6.00     8.00    4.5  1.25
; n = 2    3     -1     4.5      1.25      ?     ?
;
; Assume TOLERANCE is 0.5 for the construction of this table.

; for step n=2, mid = (3 + 4.5) / 2 = 3.75
;              (f 3.75) = -0.4375
; where  (f 3.75) = (poly 3.75)
; 

(define TOLERANCE 0.5)

; N N[>=0] -> Boolean
; true if value is between minus plus or minus tolerance
(check-expect (in-range? -0.4375) #true)
(check-expect (in-range?  0.75)   #false)
(check-expect (in-range? -0.75)   #false)

(define (in-range? value)
  (<= (abs value) TOLERANCE))

