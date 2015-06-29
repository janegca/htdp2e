;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 2901-SP-bundle) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 29.01 Sample Problem
;
; Sample Problem:
;
; Your task is to design the function bundle, which prepares the content of
; the definitions area for broadcasting. DrRacket hands over the content as
; a list of 1Strings. The function’s task is to bundle up sub-sequences of
; individual “letters” into chunks and to thus produce a list of strings—
; called chunks—of a given length, called chunk size.

; -- Example 1Strings
(define e1 (list "a" "b" "c" "d" "e" "f" "g" "h"))

; [List-of 1String] N -> [List-of String]
; bundles sub-sequences of s into strings of length n
(check-expect (bundle (explode "abcdefg") 3) (list "abc" "def" "g"))
(check-expect (bundle '("a" "b") 3) (list "ab"))
(check-expect (bundle '() 3) '())

(define (bundle s n)
  (cond
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
