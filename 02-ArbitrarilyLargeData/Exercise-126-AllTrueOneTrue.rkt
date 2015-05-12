;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-126-AllTrueOneTrue) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 126. 
;
; Design the function all-true, which consumes a list of Boolean values 
; and determines whether all of them are #true. In other words, if there
; is any #false on the list, the function produces #false; otherwise it
; produces #true.
; 
; Also design the function one-true, which consumes a list of Boolean 
; values and determines whether at least one item on the list is #true.
;
; Follow the design recipe: start with a data definition for lists of Boolean 
; values and don’t forget to make up examples.

; A List-of-Booleans is one of:
; - '()
; - (cons Boolean List-of-Booleans)
; interpretation: a List-of-Booleans represents a list of true and/or 
; false values

(check-expect (all-true (cons true (cons true (cons true '())))) true)
(check-expect (all-true (cons true (cons false (cons true '())))) false)
(check-expect (all-true '()) true)

; List-of-Booleans -> Boolean
; returns true if all values in a list of booleans are true
; or the given list is an empty list; otherwise, returns false
(define (all-true lst)
  (cond
    [(empty? lst) true]
    [(cons? lst)
     (cond [(not (first lst)) false]
           [else (all-true (rest lst))])]))

; List-Of-Booleans -> Boolean
; returns true if at least one value in a list of booleans
; is true; if all values are false or the list is empty, 
; one-true returns false
(check-expect (one-true (cons false (cons false (cons false '())))) false)
(check-expect (one-true (cons false (cons true (cons false '())))) true)
(check-expect (one-true '()) false)

(define (one-true lst)
  (cond
    [(empty? lst) false]
    [(cons? lst)
     (cond [(first lst) true]
           [else (one-true (rest lst))])]))



