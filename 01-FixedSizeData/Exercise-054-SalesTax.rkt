;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-054-SalesTax) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 54. (for 04.06 Sales Tax Sample Problem)
;
; Introduce constant definitions that separate the intervals for low prices 
; and luxury prices from the others so that the legislator in Tax Land can
; easily raise the taxes even more.

; constants
(define TAX-THRESHHOLD-1  1000)
(define TAX-THRESHHOLD-2 10000)

; Price -> Number
; computes the amount of tax charged for price p
(check-expect (sales-tax     0)  0)
(check-expect (sales-tax   537)  0)
(check-expect (sales-tax  1000) (* 0.05  1000))
(check-expect (sales-tax  1282) (* 0.05  1282))
(check-expect (sales-tax 10000) (* 0.08 10000))
(check-expect (sales-tax 12017) (* 0.08 12017))

(define (sales-tax p)  
  (cond   
    [(and (<=    0 p) (< p TAX-THRESHHOLD-1))  0]    
    [(and (<= 1000 p) (< p TAX-THRESHHOLD-2)) (* 0.05 p)]    
    [(>= p 10000) (* 0.08 p)]))





