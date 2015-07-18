;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 3203-SP-GaussianElimination) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 32.03 - Sample - Gaussian Elimination
;
; Sample Problem:
;
; In a bartering world, the values of coal (x), oil (y), and natural gas (z)
; are determined by the following exchange equations:
;
;     2x + 2y +  3z = 10
;     2x + 5y + 12z = 31
;     4x + 1y -  2z =  1
;
; A solution to such a system of equations consists of a collection of numbers,
; one per variable, such that if we replace the variable with its corresponding
; number, the two sides of each equation evaluate to the same number. In our
; running example, the solution is
;
;    x = 1, y = 1, and z = 2.
;
; We can easily check this claim:
;
;     2*1 + 2*1 +  3*2 = 10
;     2*1 + 5*1 + 12*2 = 31
;     4*1 + 1*1 -  2*2 =  1
;
;The three equations reduce to
;
;    10 = 10, 31 = 31, and 1 =1.

; An SOE is a non-empty Matrix
; constraint: if its length is n (in N), each item has length (+ n 1)
; interpretation: an SOE represents a system of linear equations
 
; An Equation is [List-of Number]
; constraint: an Equation contains at least two numbers. 
; interpretation: if (list a1 ... an b) is an Equation, a1, ..., an are
; the left-hand side variable coefficients and b is the right-hand side
 
; A Solution is [List-of Number]
 
; examples: 
(define M
  (list (list 2 2  3 10)
        (list 2 5 12 31)
        (list 4 1 -2  1)))
 
(define S '(1 1 2))

; Equation -> [List-of Number]
; extracts the left-hand side from a row in a matrix
(check-expect (lhs (first M)) '(2 2 3))
(define (lhs e)
  (reverse (rest (reverse e))))
 
; Equation -> Number
; extracts the right-hand side from a row in a matrix
(check-expect (rhs (first M)) 10)
(define (rhs e)
  (first (reverse e)))
