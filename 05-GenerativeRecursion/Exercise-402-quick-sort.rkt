;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-402-quick-sort) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 402.
;
; When you worked on exercise 396 or exercise 394, you may have produced
; looping solutions. Similarly, exercise 401 actually reveals how brittle
; the termination argument is for quick-sort. In all cases, the argument
; relies on the idea that smaller-items and larger-items produce lists that
; are maximally as long as the given list, and our understanding that neither
; includes the given pivot in the result.
;
; Based on this explanation, modify the definition of quick-sort so that both
; functions already receive lists that are shorter than the given one.

; -- solution from Exercise 396 correctly handles repeating elements

; [List-of Number] (N N -> Boolean) -> [List-of Number]
; creates a list of numbers with the same numbers as
; alon, sorted according to the comparison operator
(check-expect (quick-sort '() <) '())
(check-expect (quick-sort '(7) <) '(7))
(check-expect (quick-sort (list 11 8 14 7) <)    '(7 8 11 14))
(check-expect (quick-sort (list 11 8 14 11 7) <) '(7 8 11 11 14))
(check-expect (quick-sort (list 11 8 14 11 7) >) '(14 11 11 8 7))

(define (quick-sort alon cmp)
  (cond
    [(empty? alon) '()]
    [(empty? (rest alon)) (list (first alon))]
    [else (local ((define pivot (first alon))
                  (define part1
                    (filter (lambda (m) (cmp m pivot)) (rest alon)))
                  (define part2
                    (filter (lambda (m) (not (cmp m pivot))) (rest alon))))
            (append (quick-sort part1 cmp)
                    (list pivot)
                    (quick-sort part2 cmp)))]))


