;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-147-CheckedWages) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 147.
;
; No employee could possibly work more than 100 hours per week. To protect the 
; company against fraud, the function should check that no item of the input
; list of wage* exceeds 100. If one of them does, the function should
; immediately signal an error. How do we have to change the function in figure 
; 41 if we want to perform this basic reality check?

; -- constants
(define HOURLY-WAGE 14)
(define MAX-HOURS 100)

; List-of-numbers -> List-of-numbers
; computes the weekly wages for all given weekly hours
(check-expect (wage* '()) '())
(check-expect (wage* (cons 28 '()))
              (cons (* HOURLY-WAGE 28) '()))
(check-expect (wage* (cons 40(cons 28 '())))
              (cons (* HOURLY-WAGE 40)(cons (* HOURLY-WAGE 28) '())))
(check-error  (wage* (cons 104 '()))
              "hours exceed maximum allowed hours")

(define (wage* alon)  
  (cond    [(empty? alon) '()]  
           [else (cons (wage (first alon)) (wage* (rest alon)))])) 

; Number -> Number
; computes the wage for h hours of work
(define (wage h)  
  (if (< h MAX-HOURS)
      (* HOURLY-WAGE h)
      (error "hours exceed maximum allowed hours")))

