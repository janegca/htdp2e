;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-259-Sets) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 259. 
;
; Design a data representation for finite and infinite sets so that you can
; represent the sets of all odd numbers, all even numbers, all numbers 
; divisible by 10, etc. 
;
; Hint:  Mathematicians sometimes interpret sets as functions that consume a 
; potential element e and produce #true if the e belongs to the set and #false
; if it doesn’t.
;
; Design the functions
;
;    add-element, which adds an element to a set;
;
;    union, which combines the elements of two sets; and
;
;    intersect, which collects all elements common to two sets;
;
; Keep in mind the analogy between sets and shapes.

; Set is a function:
;    [Number -> Boolean]
; interpretation: if s is a set and n is a number then (s n) produces
; #true if n is in s, #false otherwise

; example sets

; Set Number -> Boolean

; Number -> Set
; return #true if the number belongs to the set of even numbers
(check-expect (even-number 1) #false)
(check-expect (even-number 2) #true)

(define even-number 
  (lambda (n)
    (even? n)))

; Number -> Set
; return #true if the number belongs to the set of odd numbers
(check-expect (odd-number 1) #true)
(check-expect (odd-number 2) #false)

(define odd-number
  (lambda (n)
    (odd? n)))

; Number -> Set
; return #true if the number belongs to the set of numbers 
; evenly divisible by ten
(check-expect (div-by-10 10) #true)
(check-expect (div-by-10 59) #false)

(define div-by-10
  (lambda (n)
    (= 0 (modulo n 10))))


; Number -> Boolean
; returns #true if the number is added to the set
(check-expect ((add-element even-number) 1) #false)
(check-expect ((add-element even-number) 2) #true)

(define (add-element s)
  (lambda (n)
    (s n)))

; Number -> Boolean
; returns #true if a number is combined elements of two sets
(check-expect ((union even-number div-by-10)  6) #true)
(check-expect ((union odd-number  div-by-10)  5) #true)
(check-expect ((union odd-number  div-by-10) 50) #true)
(check-expect ((union odd-number  div-by-10) 16) #false)

(define (union s1 s2)
  (lambda (n)
    (or (s1 n) (s2 n))))

; Number -> Boolean
; returns #true if number is in the collected elements common to two sets
(check-expect ((intersect even-number div-by-10) 60) #true)
(check-expect ((intersect even-number div-by-10) 32) #false)

(define (intersect s1 s2)
  (lambda (n)
    (and (s1 n) (s2 n))))