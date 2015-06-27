;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-369-gift-lottery) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 369.
;
; Louise, Jane, Laura, Dana, and Mary decided to run a lottery that assigns
; one gift recipient to each of them. Since Jane is a computer programmer,
; they ask her to write a program that performs this lottery in an impartial
; manner. Of course, the program must not assign any of the sisters to herself.
;
; The core of Jane’s program is shown below. It consumes a list of names and
; randomly picks one of those permutations that do not agree with the original
; list at any place.
;
; Your task is to design two auxiliary functions: random-pick and non-same-names
; Recall that random picks a random number; see exercise 87.

(require 2htdp/abstraction)

; [List-of String] -> [List-of String] 
; picks a “random” non-identity arrangement of names
(define (gift-pick names)
  (random-pick
   (non-same names (arrangements names))))

; [List-of X] -> [List-of [List-of X]]
; creates a list of all rearrangements of the items in w
; (see EX-Arrangements in 03-Intermezzo-Scope)
(define (arrangements w)
  (cond
    [(empty? w) '(())]
    [else (for*/list ([item w]
                      [arrangement-without-item
                       (arrangements (remove item w))])
            (cons item arrangement-without-item))]))

; [List-of X] -> X 
; returns a random item from the list 
; assume the list is not empty
(define (random-pick l)
  (local ((define num (random (length l))))
    (list-ref l num)))

; [List-of String] [List-of [List-of String]] 
; -> 
; [List-of [List-of String]]
; produces the list of those lists in ll that do not agree 
; with names at any place
(check-expect (non-same '("Laura" "Mary")
                        '(("Mary" "Laura")
                          ("Laura" "Mary")))
              '(("Mary" "Laura")))

(define (non-same names ll)
  (cond [(empty? ll) '()]
        [(ormap identity (map equal? names (first ll)))
         (non-same names (rest ll))]
        [else (cons (first ll)
                    (non-same names (rest ll)))]))

; -- example usage
(gift-pick  '("Louise" "Jane" "Laura" "Dana" "Mary"))

