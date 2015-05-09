;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-119-ListOfBooleans) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 119. 
; Provide a data definition for representing lists of Boolean values. 
; The class contains all arbitrarily long lists of Booleans.

; A List-of-Booleans is one of:
; - '()
; - (cons Boolean List-of-Booleans
; interpretation: a List-of-Booleans represents a true and/or false values

