;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-401-problemWithSmallerItems) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 401.
; Consider the following definition of smaller-items, one of the two “problem
; generators” for quick-sort:

    ; [List-of Number] Number -> [List-of Number]
    ; creates a list with all those numbers on alon
    ; that are smaller than or equal to threshold
    (define (smaller-items alon threshold)
      (cond
        [(empty? alon) '()]
        [else (if (<= (first alon) threshold)
                  (cons (first alon) (smaller-items (rest alon) threshold))
                  (smaller-items (rest alon) threshold))]))

; What can go wrong when this version is used with the quick-sort definition
; from Recursion that Ignores Structure?

; Answer: if the threshold occurs in the list more than once and <=
;         is used the value will be kept as the first element of the list
;         i.e. the list will never shrink and the method will not terminate

