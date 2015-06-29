;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-396-variant-of-quick-sort) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 396.
;
; Develop a variant of quick-sort that uses only one comparison function,
; say, <. Its partitioning step divides the given list alon into a list that
; contains the items of alon smaller than (first alon) and another one with
; those that are not smaller.
;
; Use local to package up the program as a single function: Abstract this
; function so that it consumes a list and a comparison function.

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





