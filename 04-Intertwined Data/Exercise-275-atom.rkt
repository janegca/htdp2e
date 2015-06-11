;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-275-atom) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 275. 
; 
; Define the atom? function. 

(require 2htdp/image)

; An Atom is one of: 
; – Number
; – String
; – Symbol 

; Any -> Boolean
(check-expect (atom? 10)      #true)
(check-expect (atom? "hello") #true)
(check-expect (atom? 'a)      #true)
(check-expect (atom? (circle 3 "solid" "red")) #false)

(define (atom? v)
  (or (number? v)
      (string? v)
      (symbol? v)))
