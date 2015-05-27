;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-210-EvalSquared) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 210. 
;
; Evaluate (squared>? 3 10), (squared>? 4 10), and (squared>? 5 10) by hand. 
; Then show that
;
;    (extract squared>? (list 3 4 5) 10)
;
; evaluates to (list 4 5). 

; Number Number -> Boolean
; is the area of a square with side x larger than c
(define (squared>? x c)
  (> (* x x) c))

;    (squared>? 3 10)
; == (> (* 3 3) 10
; == (> 9 10)
; == #false

;    (squared>? 4 10)
; == (> (* 4 4) 10)
; == (> 16 10)
; == #true

;    (squared>? 5 10)
; == (> (* 5 5) 10)
; == (> 25 10)
; == #true

;    (extract squared>? (list 3 4 5) 10)
; == (extract squared>? (list 4 5) 10)
; == (list 4 5)

; Relation List Threshold -> List
; returns a list of all elements in the list that satisfy the relation
; and are within the threshold
(define (extract R l t)
  (cond
    [(empty? l) '()]
    [else (cond
            [(R (first l) t)
             (cons (first l) (extract R (rest l) t))]
            [else
             (extract R (rest l) t)])]))

(extract squared>? (list 3 4 5) 10)