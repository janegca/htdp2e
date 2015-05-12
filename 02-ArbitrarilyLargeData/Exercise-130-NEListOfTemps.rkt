;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-130-NEListOfTemps) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 130. 
;
; Would sum and how-many work for NEList-of-temperatures even if they were 
; designed for inputs from List-of-temperatures? If you think they don’t 
; work, provide counter-examples. If you think they would, explain why.
;
; [Note: everything works the same, only the data definition has changed
;        programmer's are expected to pass non-empty lists]
;
; A NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of measured temperatures 

; NEList-of-temperatures -> Number
; computes the average temperature 
(check-expect (average (cons 1 (cons 2 (cons 3 '())))) 2) 

(define (average anelot) 
  (/ (sum anelot)   
     (how-many anelot)))

; List -> Number
; returns the number of elements in a lis
(define (how-many lst)  
  (cond    [(empty? lst) 0]  
           [else (+ 1 (how-many (rest lst)))]))

; List-of-temperatures -> Number 
; adds up the temperatures on the given list]
(define (sum alot)
  (cond   
    [(empty? alot) 0]  
    [else (+ (first alot) (sum (rest alot)))]))
