;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-249-find-name) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 249
;
; Re-write Exercise 236 using lambdas vs local functions

; String [List-of String] -> Boolean
(check-expect (find-name "John" '()) false)
(check-expect (find-name "John" (list "John")) true)
(check-expect (find-name "Paul" (list "John" "Paul" "Ringo" "George")) true)

(define (find-name name los)
    (ormap (lambda (s) (string-contains? name s))
           los))

; 1String [List-of String] -> Boolean
; returns true if all names in the list of strings begin with
; the given 1String
(check-expect (all-begin-with? "a" '()) true)
(check-expect (all-begin-with? "" (list "hello")) false)
(check-expect (all-begin-with? "a" (list "and" "after" "am")) true)

(define (all-begin-with? c los)
  (andmap (lambda (s) (string=? c (string-ith s 0)))
          los))

; Number [List-of String] -> Boolean
; returns true if any string exceeds the given width (w)
(check-expect (any-exceed-width? 2 '()) false)
(check-expect (any-exceed-width? 3 (list "cat" "hat" "mine" "dog")) true)

(define (any-exceed-width? w los)
    (ormap (lambda (s) (> (string-length s) w))
           los))
