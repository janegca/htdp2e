;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-230-extract1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 230. 
; 
; Consider the following function definition:

    ; Inventory -> Inventory
    ; creates an Inventory from an-inv for all
    ; those items that cost less than $1
    (define (extract1 an-inv)
      (cond
        [(empty? an-inv) '()]
        [else (cond
                [(<= (ir-price (first an-inv)) 1.0)
                 (cons (first an-inv) (extract1 (rest an-inv)))]
                [else (extract1 (rest an-inv))])]))

; Both clauses in the nested cond expression extract the first item from
; an-inv and both compute (extract1 (rest an-inv)). Use a local expression 
; to name the repeated expressions. Does this help increase the speed at 
; which the function computes its result? Significantly? A little bit?
; Not at all? 
;
; Ans: don't see any difference in execution time

(define-struct ir [price s])

(check-expect (extract1 '()) '())
(check-expect (extract1 (list (make-ir 0.5 "toy1")
                              (make-ir 1.1 "toy2")
                              (make-ir 0.75 "toy3")))
              (list (make-ir 0.5 "toy1") (make-ir 0.75 "toy3")))

(check-expect (extract1.v2 '()) '())
(check-expect (extract1.v2 (list (make-ir 0.5 "toy1")
                                 (make-ir 1.1 "toy2")
                                 (make-ir 0.75 "toy3")));              
              (list (make-ir 0.5 "toy1") (make-ir 0.75 "toy3")))

(define (extract1.v2 an-inv)
      (cond
        [(empty? an-inv) '()]
        [else 
         (local ( (define get-rem   (extract1.v2 (rest an-inv)))
                  (define get-first (first an-inv)) )
           (cond             
           [(<= (ir-price get-first) 1.0)
            (cons get-first get-rem)]
           [else get-rem]))]))

(define ex01 (list (make-ir 0.25 "t1")
                   (make-ir 2.0  "t2")
                   (make-ir 1.23 "t3")
                   (make-ir 0.35 "t4")
                   (make-ir 0.70 "t5")))