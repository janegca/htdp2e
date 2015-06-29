;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-393-modified-quick-sort) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 393.
;
; While quick-sort quickly reduces the size of the problem in many cases,
; it is inappropriately slow for small problems. Hence people use quick-sort
; to reduce the size of the problem and switch to a different sort function
; when the list is small enough.
;
; Develop a version of quick-sort that uses sort> from Recursive Auxiliary
; Functions if the length of the input is below some threshold.

; -- QuickSort Example modified for this exercise

; [List-of Number] -> [List-of Number]
; creates a list of numbers with the same numbers as
; alon, sorted in ascending order
; assume the numbers are all distinct
(check-expect (quick-sort (list 11 8 14 7)) '(7 8 11 14))

(define (quick-sort alon)
  (cond
    [(empty? alon) '()]
    [(< (length alon) 3) (sort alon <)]         ; added for this exercise
    [else (local ((define pivot (first alon)))
            (append (quick-sort (smaller-items alon pivot))
                    (list pivot)
                    (quick-sort (larger-items alon pivot))))]))
 
; [List-of Number] Number -> [List-of Number]
; creates a list with all those numbers on alon  
; that are larger than n
(define (larger-items alon n)
  (cond
    [(empty? alon) '()]
    [else (if (> (first alon) n)
              (cons (first alon) (larger-items (rest alon) n))
              (larger-items (rest alon) n))]))
 
; [List-of Number] Number -> [List-of Number]
; creates a list with all those numbers on alon  
; that are smaller than n
(define (smaller-items alon n)
  (cond
    [(empty? alon) '()]
    [else (if (< (first alon) n)
              (cons (first alon) (smaller-items (rest alon) n))
              (smaller-items (rest alon) n))]))


