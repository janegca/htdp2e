;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-400-bundle-checked-version) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 400.
;
; Develop a checked version of bundle that is guaranteed to terminate for all
; inputs. It may signal an error for those cases where the original version
; loops.

; [List-of 1String] N -> [List-of String]
; bundles sub-sequences of s into strings of length n
(check-expect (bundle (explode "abcdefg") 3) (list "abc" "def" "g"))
(check-expect (bundle '("a" "b") 3) (list "ab"))
(check-expect (bundle '() 3) '())
(check-error  (bundle (explode "abcdefg") 0))

(define (bundle s n)
  (cond
    [(eq? n 0)  (error "zero grouping not allowed")]
    [(empty? s) '()]
    [else (cons (implode (take s n)) (bundle (drop s n) n))]))
 
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
