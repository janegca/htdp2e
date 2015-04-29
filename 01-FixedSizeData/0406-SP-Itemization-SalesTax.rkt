;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0406-SP-Itemization-SalesTax) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 04.06 Sample Problem - Itemization - Sales Tax
;
; The state of Tax Land has created a three-stage sales tax to cope with its 
; budget deficit. Inexpensive items, those costing less than $1,000, are not
; taxed. Luxury items, with a price of more than $10,000, are taxed at the 
; rate of eight percent (8.00%). Everything in between comes with a five
; percent (5%) mark up.
;
; Design a function for a cash register that given the price of an item, 
; computes the sales tax.

; Step 1 - establish data definitions
;
; A Price falls into one of three intervals: 
; — 0     through 1000;     - no tax
; — 1000  through 10000;    - taxed at 5% >=  1,000
; — 10000 and above.        - taxed at 8% >= 10,000
; interpretation: the price of an item 

; functions

; Step 2-3: determine what function(s) are needed and 
;           appropriate tests for each data defintion
;
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
    [(and (<=    0 p) (< p 1000))  0]    
    [(and (<= 1000 p) (< p 10000)) (* 0.05 p)]    
    [(>= p 10000) (* 0.08 p)]))







