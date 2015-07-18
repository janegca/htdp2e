;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-436-triangulation) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 436.
;
; Check that the following system of equations:
;
;     2x + 3y + 2z = 10
;          3y + 9z = 21
;               1z = 2
;
; has the same solution as the one labeled with (). Do so by hand and with
; check-solution from exercise 435.

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

; Equation Solution -> Number
; plug's the solutions into the equation returning a result
(check-expect (plug-in (lhs (first M)) S) 10)

(define (plug-in eq s)
  (cond [(empty? eq) 0]
        [else (+ (* (first eq) (first s))
                 (plug-in (rest eq) (rest s)))]))

; SOE Solution -> Boolean
; #true if the solution satisfies alle equation in the SOE
(check-expect (check-solution M S) #true)

(define (check-solution soe s)
  (cond [(empty? soe) #true]
        [else (and (= (plug-in (lhs (first soe)) s) (rhs (first soe)))
                   (check-solution (rest soe) s))]))

(define N
  (list (list 2 2 3 10)
        (list 0 3 9 21)
        (list 0 0 1  2)))

(check-solution N S)