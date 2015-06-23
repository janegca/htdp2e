;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-275-find-name) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 275.
;
; Define find-name. The function consumes a name and a list of names. It
; retrieves the first name on the latter that is equal to, or an extension of,
; the former.
;
; Define a function that ensures that no name on some list of names exceeds
; some given width. Compare with exercise 236.

(require 2htdp/abstraction)

; String [List-of String] -> Boolean
(check-expect (find-name "John" '()) false)
(check-expect (find-name "John" (list "JohnLennon")) "JohnLennon")
(check-expect (find-name "Paul" (list "John" "Paul" "Ringo" "George")) "Paul")

(define (find-name name los)
  (for/or ([str los]) (if (string-contains? name str) str #false)))

; Number [List-of String] -> Boolean
; returns true if any string exceeds the given width (w)
(check-expect (any-exceed-width? 2 '()) false)
(check-expect (any-exceed-width? 3 (list "cat" "hat" "mine" "dog")) true)

(define (any-exceed-width? w los)
  (for/or ([name los]) (> (string-length name) w)))