;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-395-QuickSortUsingFilters) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 395.
;
; Use filter to define smaller-items and larger-items as one-liners.

; [List-of Number] -> [List-of Number]
; creates a list of numbers with the same numbers as
; alon, sorted in ascending order
(check-expect (quick-sort '()) '())
(check-expect (quick-sort '(7)) '(7))
(check-expect (quick-sort (list 11 8 14 7)) '(7 8 11 14))
(check-expect (quick-sort (list 11 8 14 11 7)) '(7 8 11 11 14))

(define (quick-sort alon)
  (cond
    [(empty? alon) '()]
    [(empty? (rest alon)) (list (first alon))]
    [else (local ((define pivot (first alon)))
            (append (quick-sort (filter (lambda (m) (<= m pivot)) (rest alon)))
                    (list pivot)
                    (quick-sort (filter (lambda (m) (> m pivot)) alon))))]))

