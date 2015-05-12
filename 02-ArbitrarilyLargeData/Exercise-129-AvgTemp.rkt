;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-129-AvgTemp) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 129.
;
; Determine how average behaves in DrRacket when applied to the empty list 
; of temperatures. Then design checked-average, a function that produces an
; informative error message when it is applied to '().

; A List-of-temperatures is one of: 
; – '()
; – (cons CTemperature List-of-temperatures) 
; A CTemperature is a Number greater or equal to -256. 

; List-of-temperatures -> Number
; computes the average temperature 
(check-expect (average (cons 1 (cons 2 (cons 3 '())))) 2)

(define (average alot) 
  (/ (sum alot)    
     (how-many alot)))

; List-of-temperatures -> Number
; returns the average of a list of temperatures or an error
; if the list is empty
(check-error (checked-average '())
             "the list must not be empty")
(check-expect (checked-average (cons 1 (cons 2 (cons 3 '())))) 2)
              
(define (checked-average alot)
  (cond
    [(empty? alot) (error "the list must not be empty")]
    [else (/ (sum alot) (how-many alot))]))

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


