;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-017-BoolImply) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 17. 
; Define the function bool-imply. It consumes two Boolean values, call them 
; sunny and friday. The answer of the function is #true if sunny is false or 
; friday is true.

(define (bool-imply sunny friday) (or (not sunny) friday))

(bool-imply #false #true)

  