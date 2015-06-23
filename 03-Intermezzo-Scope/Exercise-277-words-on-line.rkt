;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-277-words-on-line) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 277.
;
; Figure 45 displays a function that determines the number of words per
; nested list in a list of list of strings. Using the notation from
; Abstraction, the function’s signature, purpose and header can be
; formulated like this:

    ; [List-of [List-of String]] -> [List-of Number]
    ; determines the number of words on each line 
    ;(define (words-on-line lls)
    ;  '())

; Define the function using match.

; -- code from Figure 45

; A LLS is one of: 
; – '()
; – (cons Los LLS)
; interpretation a list of lines, each line is a list of strings
 
(define line0 (cons "hello" (cons "world" '())))
(define line1 '())
 
(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))

; LLS -> List-of-numbers
; determines the number of words on each line 
 
(check-expect (words-on-line lls0) '())
(check-expect (words-on-line lls1) (cons 2 (cons 0 '())))
 
(define (words-on-line.v0 lls)
  (cond
    [(empty? lls) '()]
    [else (cons (length (first lls))
                (words-on-line (rest lls)))]))

; -- revised words-on-line function

(require 2htdp/abstraction)

(define (words-on-line lls)
  (match lls
    ['() '()]
    [(cons head tail) (cons (length head) (words-on-line tail))]))

