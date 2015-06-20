;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname SP-EnumerateFn) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Sample Problem: 
; Design enumerate. The function consumes a list and produces a list of the 
; same items paired with their relative index.

; here's the solution using buld-list

(check-expect (enumerate '(a b c)) '((1 a) (2 b) (3 c)))

(define (enumerate lst)
  (build-list (length lst)
              (lambda (i) 
                (list (+ i 1) (list-ref lst i)))))

; this is the solution using for/list (available in DrRacket v6.2 2015-06-20)
(require 2htdp/abstraction)

; [List-of X] -> [List-of [List N X]]
; pair each item in the list with its index 
(check-expect (enumerate.loop '(a b c)) '((1 a) (2 b) (3 c)))

(define (enumerate.loop lst)
  (for/list ((item lst) (ith (length lst)))
    (list (+ ith 1) item)))


; [List-of X] [List-of Y] -> [List-of [List X Y]]
; generate all possible pairs of items from l1 and l2
(check-satisfied (enumerate.loop.v1 '(a b c))
                 (lambda (c) (= (length c) 9)))

(define (enumerate.loop.v1 lst)
  (for*/list ((i (length lst)) (j lst))
    (list i j)))
