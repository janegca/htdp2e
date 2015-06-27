;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-368-linear-combinations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 368.
;
; A linear combination is the sum of many linear terms, that is, products of
; variables and numbers. The latter are called coefficients in this context.
; Here are some examples:
;
;   5x    5x + 17y    5x + 17y + 3z
;
; In all three examples, the coefficient of x is 5, that of y is 17, and the
; one for z is 3.
;
; If we are given values for variables, we can determine the value of a
; polynomial. For example, if x = 10, the value of5x  is 50; if x = 10 and
; y = 1, the value of 5x + 17y is 67; and if x = 10, y = 1, and z = 2,
; the value of  5x + 17y + 3z is 73.
;
; There are many different representations of linear combinations. We could,
; for example, represent them with functions. An alternative representation
; is a list of its coefficients. The above combinations would be represented
;as:
;
;    (list 5)
;    (list 5 17)
;    (list 5 17 3)
;
; This choice of representation assumes a fixed order of variables.
;
; Design value. The function consumes two equally long lists: a linear
; combination and a list of variable values. It produces the value of the
; combination for these values.

; [List-of Number] [List-of Number] -> Number
; the value of a linear combination (cmb) as computed with the given
; variable values (vars).
; assume the lists are of equal length
(check-expect (value '(5)      '(10))     50)
(check-expect (value '(5 17)   '(10 1))   67)
(check-expect (value '(5 17 3) '(10 1 2)) 73)

(define (value cmb vars)
  (cond [(empty? cmb) 0]
        [else (+ (* (first cmb) (first vars))
                 (value (rest cmb) (rest vars)))]))


        

