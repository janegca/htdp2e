;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-022-StringDeleteFn) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 22. 
; Define the function string-delete, which consumes a string and a number i
; and which deletes the ith position from str. Assume i is a number between 0 
; (inclusive) and the length of the given string (exclusive)

(define (string-delete str idx)
  (string-append (substring str 0 idx) 
                 (substring str (+ idx 1) (string-length str))))

(string-delete "hello_world" 5)
