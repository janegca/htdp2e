;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-136-AddNToPi) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 136.
;
; Design the function add-to-pi. It consumes a natural number n and adds it 
; to pi without using + from BSL. Here is a start:

    ; N -> Number
    ; computes (+ n pi) without using +
     
    ;(check-within (add-to-pi 3) (+ 3 pi) 0.001)
     
    ;(define (add-to-pi n)
    ;  pi)

; Once you have a complete definition, generalize the function to add, 
; which adds a natural number n to some arbitrary number x without using +. 
; Why does the skeleton use check-within?
;
; Ans: pi is an irrational number with an infinite number of decimals
;      just want to make sure we're reasonably close (here, within 0.001 or
;      three decimal places of accuracy) to the value

; N -> Number
; computes (+ n pi) without using +
(check-within (add-to-pi 3) (+ 3 pi) 0.001)
     
(define (add-to-pi n)
    (cond
      [(zero? n) pi]
      [(positive? n) (add1 (add-to-pi (sub1 n)))]))



