;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-364-merge) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 364.
;
; Design merge. The function consumes two lists of numbers, sorted in
; ascending order. It produces a single sorted list of numbers that contains
; all the numbers on both inputs lists (and nothing else). A number occurs
; in the output as many times as it occurs on the two input lists together.

; [List-of Number] [List-of Number] -> [List-of Number
; merge two sorted lists
(check-expect (merge '(1 2 3) '()) '(1 2 3))
(check-expect (merge '() '(1 2 3)) '(1 2 3))
(check-expect (merge '(1 2 3) '(1 2 3)) '(1 1 2 2 3 3))
(check-expect (merge '(1 3 5) '(2 4 6)) '(1 2 3 4 5 6))

(define (merge m* n*)
  (cond [(empty? m*) n*]
        [(empty? n*) m*]
        [(= (first m*) (first n*))
         (cons (first m*) (cons (first n*) (merge (rest m*) (rest n*))))]
        [(< (first m*) (first n*))
         (cons (first m*) (merge (rest m*) n*))]
        [else (cons (first n*) (merge m* (rest n*)))]))


