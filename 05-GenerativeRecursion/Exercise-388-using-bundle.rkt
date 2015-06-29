;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-388-using-bundle) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 388.
;
; Is (bundle "abc" 0) a proper use of the bundle function? What does it
; produce? Why?

; Ans: creates the infinite processing of the initial string, which
;      never changes:
;
;     (bundle "abc" 0)
;  -> (cons (implode (take s n)) (bundle (drop s n) n))
;  -> (cons (take '("a" "b" "c") 0) (bundle (drop "abc" 0) 0)
;  -> (cons '() (bundle "abc" 0))
;  -> (cons '() (cons ...
