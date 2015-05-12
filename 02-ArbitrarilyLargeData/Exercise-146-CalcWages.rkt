;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-146-CalcWages) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 146. 
;
; Translate the examples into tests and make sure they all succeed. Then 
; change the function in figure 41 so that everyone gets $14 per hour. 
; Now revise the entire program so that changing the wage for everyone is a 
; single change to the entire program and not several.

; -- constants
;
(define HOURLY-WAGE 14)

; List-of-numbers -> List-of-numbers
; computes the weekly wages for all given weekly hours
(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '()))
              (cons (* HOURLY-WAGE 28) '()))
(check-expect (wage* (cons 40(cons 28 '())))
              (cons (* HOURLY-WAGE 40)(cons (* HOURLY-WAGE 28) '())))

(define (wage* alon)  
  (cond    [(empty? alon) '()]  
           [else (cons (wage (first alon)) (wage* (rest alon)))])) 

; Number -> Number
; computes the wage for h hours of work
(define (wage h)  
  (* HOURLY-WAGE h))

