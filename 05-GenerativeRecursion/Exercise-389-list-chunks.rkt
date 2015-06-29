;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-389-list-chunks) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 389.
;
; Define the function list->chunks. It consumes a list l of arbitrary data
; and a natural number n. The function’s result is a list of list chunks of
; size n. Each chunk represents a sub-sequence of items in l.
;
; Use list->chunks to define bundle via function composition.

; [List-of 1String] N -> [List-of String]
; bundles sub-sequences of s into strings of length n
(check-expect (bundle (explode "abcdefg") 3) (list "abc" "def" "g"))
(check-expect (bundle '("a" "b") 3) (list "ab"))
(check-expect (bundle '() 3) '())

(define (bundle s n)
  (map implode (list->chunks s n)))

; [List-of Any] N -> [List-of [List-of Any]]
; breaks a list into subsequences of size n
(check-expect (list->chunks '(a b c d) 2) '((a b) (c d)))
(check-expect (list->chunks '(a b c)   2) '((a b) (c)))
(check-expect (list->chunks '(a b)     3) '((a b)))
(check-expect (list->chunks '()        3) '())

(define (list->chunks a* n)
  (cond [(empty? a*) '()]
        [else (cons (take a* n) (list->chunks (drop a* n) n))]))

; [List-of X] N -> [List-of X]
; retrieves the first n items in l if possible or everything 
(define (take l n)
  (cond
    [(zero?  n) '()]
    [(empty? l) '()]
    [else (cons (first l) (take (rest l) (sub1 n)))]))
 
; [List-of X] N -> [List-of X]
; remove the first n items from l if possible or everything 
(define (drop l n)
  (cond
    [(zero?  n) l]
    [(empty? l) l]
    [else (drop (rest l) (sub1 n))]))

