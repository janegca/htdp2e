;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-021-StringInsertFn) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 21. 
; Define the function string-insert, which consumes a string and a number i 
; and which inserts "_" at the ith position of the string. Assume i is a 
; number between 0 and the length of the given string (inclusive).

(define (string-insert str idx)
  (string-append (string-append (substring str 0 idx) "_")
                 (substring str idx (string-length str))))

(string-insert "helloworld" 5)
