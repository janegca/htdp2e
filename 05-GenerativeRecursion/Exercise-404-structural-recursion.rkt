;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-404-structural-recursion) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 404.
;
;         (define (special P)
;           (cond [(empty? P) (solve P)]
;                 [else (combine-solutions
;                        P
;                        (special (rest P)))]))
;
; Define solve and combine-solutions so that:
;
; 1. special computes the length of its input,
; 2. special negates each number on the given list of numbers, and
; 3. special uppercases the given list of strings.
;
; What do you conclude from these exercises?

; -- compute length of input
(check-expect (compute-length '()) 0)
(check-expect (compute-length '(1 2 3)) 3)

(define (compute-length P)
  (cond
    [(empty? P) 0]
    [else
      (+ 1 (compute-length (rest P)))]))

; -- negate each number
(check-expect (negate '()) '())
(check-expect (negate '(1 2 3)) '(-1 -2 -3))

(define (negate P)
  (cond
    [(empty? P) '()]
    [else
      (cons (* -1 (first P))
            (negate (rest P)))]))

; -- uppercase list of strings

(check-expect (toUpper '()) '())
(check-expect (toUpper '("abc")) '("ABC"))
(check-expect (toUpper '("abc" "def" "g")) '("ABC" "DEF" "G"))

(define (toUpper P)
  (cond
    [(empty? P) '()]
    [else
      (cons (list->string (map char-upcase (string->list (first P))))
            (toUpper (rest P)))]))

; Ans: all functions assume input is finite