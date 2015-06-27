;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-365-dropAndTake) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 365.
;
; Design the function drop. It consumes a list l and a natural number n.
; Its result is l with the first n items removed or just the empty list
; if l is too short.
;
; Design the function take. It consumes a list l and a natural number n.
; Its result is the list of the first n items from l or all of l if it is
; too short.

; [List-of Any] Number -> [List-of Any]
; the list less the first n elements
(check-expect (drop '() 2) '())
(check-expect (drop '(1 2 3) 5) '())
(check-expect (drop '(1 2 3) 2) '(3))

(define (drop a* n)
  (cond [(empty? a*) '()]
        [(= n 0) a*]
        [else (drop (rest a*) (- n 1))]))

; [List-of Any] Number -> [List-of Any]
; the first n elements of the list
(check-expect (take '() 3) '())
(check-expect (take '(1 2) 3) '(1 2))
(check-expect (take '(1 2 3 4) 3) '(1 2 3))

(define (take a* n)
  (cond [(empty? a*) '()]
        [(= n 0)     '()]
        [else (cons (first a*) (take (rest a*) (- n 1)))]))


