;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-133-NEListOfBooleans) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 133. 
; Develop a data definition for NEList-of-Booleans, a representation of 
; non-empty lists of Boolean values. Then re-design the functions all-true 
; and one-true from exercise 126.

; An NEList-of-Booleans is one of:
; - (cons Boolean '())
; - (cons Boolean NEList-of-Booleans)
; interpretation: a non-empty List-of-Booleans represents a list of
; true and/or false values with at least one value

; NEList-of-Booleans -> Boolean
; returns true if all values in a non-empty list of booleans are true
(check-expect (all-true (cons true (cons true (cons true '())))) true)
(check-expect (all-true (cons true (cons false (cons true '())))) false)
(check-expect (all-true (cons false '())) false)
(check-expect (all-true (cons true '())) true)

(define (all-true anelob)
  (cond
    [(empty? (rest anelob)) (first anelob)]
    [(cons?  (rest anelob))
     (cond [(first anelob) (all-true (rest anelob))]
           [else false])]))

; NEList-of-Booleans -> Boolean
; returns true if at least one value in a non-empty list of booleans is true
(check-expect (one-true (cons false (cons false (cons false '())))) false)
(check-expect (one-true (cons false (cons true (cons false '())))) true)
(check-expect (one-true (cons false '())) false)
(check-expect (one-true (cons true '())) true)

(define (one-true anelob)
  (cond
    [(empty? (rest anelob)) (first anelob)]
    [(cons?  (rest anelob))
     (cond [ (first anelob) true]
           [else (one-true (rest anelob))])]))

