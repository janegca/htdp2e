;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-399-food-create) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 399.
;
; Exercise 198 defines the function food-create, which consumes a Posn and
; produces a randomly chosen, guaranteed distinct Posn. The exercise defers
; to this part of the book for an explanation of the design of the function.
; Justify the design of food-create. Re-formulate the two functions as a
; single definition; use local.

(define RADIUS   10)
(define DIAMETER (* 2  RADIUS))
(define MAX      (- DIAMETER 2))

; Posn -> Posn 
; generates a random position for the placement of the worm food

(check-satisfied (food-create (make-posn 1 1)) not-equal-1-1?)
 
(define (food-create p)
  (local ((define (check-create candidate)
            (if (equal? p candidate) (food-create p) candidate)))
            
  (check-create (make-posn (random MAX) (random MAX)))))
 
; Posn -> Boolean
; use for testing only 
(define (not-equal-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))
