;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-236-find-name) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 236. 
; 
; Use ormap to define find-name. The function consumes a name and a list of 
; names. It determines whether any of the names on the latter are equal to or
; an extension of the former.
;
; With andmap you can define a function that checks all names on a list of 
; names start with the letter "a".
;
; Should you use ormap or andmap to define a function that ensures that no 
; name on some list exceeds some given width? 


; String [List-of String] -> Boolean
(check-expect (find-name "John" '()) false)
(check-expect (find-name "John" (list "John")) true)
(check-expect (find-name "Paul" (list "John" "Paul" "Ringo" "George")) true)

(define (find-name name los)
  (local (; String -> Boolean
          (define (has-name? s)
            (string-contains? name s)))
    (ormap has-name? los)))

; 1String [List-of String] -> Boolean
; returns true if all names in the list of strings begin with
; the given 1String
(check-expect (all-begin-with? "a" '()) true)
(check-expect (all-begin-with? "" (list "hello")) false)
(check-expect (all-begin-with? "a" (list "and" "after" "am")) true)

(define (all-begin-with? c los)
  (local (; String -> Boolean
          (define (begins-with? s)
            (string=? c (string-ith s 0))))       
        (andmap begins-with? los)))

; Number [List-of String] -> Boolean
; returns true if any string exceeds the given width (w)
(check-expect (any-exceed-width? 2 '()) false)
(check-expect (any-exceed-width? 3 (list "cat" "hat" "mine" "dog")) true)

(define (any-exceed-width? w los)
  (local (; String -> Boolean
          (define (too-wide? s)
            (> (string-length s) w)))
    (ormap too-wide? los)))