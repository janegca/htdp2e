;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-125-AllPositiveNumbers) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 125. 
;
; Now take a look at this data definition:

    ; A List-of-numbers is one of: 
    ; – '()
    ; – (cons Number List-of-numbers)

; Some elements of this class of data are appropriate inputs for sum from
; exercise 124 and some aren’t.
;
; Design the function pos?, which consumes a List-of-numbers and determines
; whether all numbers are positive numbers. In other words, if (pos? l) yields
; #true, then l is an element of List-of-amounts.

; List-of-Numbers -> Boolean
; returns true if all numbers in the given list are positive; otherwise,
; returns false
(check-expect (pos? '()) true)
(check-expect (pos? (cons 1 (cons 2 (cons 3 '())))) true)
(check-expect (pos? (cons 1 (cons 2 (cons -3'())))) false)

(define (pos? lst)
  (cond
    [(empty? lst) #true]
    [(cons?  lst)
     (cond [(< (first lst) 0)  #false]
           [else (pos? (rest lst))])]))

           
