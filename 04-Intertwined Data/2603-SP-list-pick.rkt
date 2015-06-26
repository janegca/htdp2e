;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 2603-SP-list-pick) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 26.03 Sample Problem

; Sample Problem:
;    Given a list of symbols los and a natural number n, the function
;    list-pick extracts the nth symbol from los; if there is no such symbol,
;    it signals an error.


; [List-of Symbol] N -> Symbol
; extracts the nth symbol from l; 
; signals an error if there is no such symbol
(check-expect (list-pick '(a b c) 2)      'c)
(check-expect (list-pick (cons 'a '()) 0) 'a)

(check-error  (list-pick '() 0)           "list-pick: list too short")
(check-error  (list-pick '() 3)           "list-pick: list too short")
(check-error  (list-pick (cons 'a '()) 3) "list-pick: list too short")

(define (list-pick.v0 l n)
  (cond
    [(and (= n 0) (empty? l))
     (error 'list-pick "list too short")]
    [(and (> n 0) (empty? l))
     (error 'list-pick "list too short")]
    [(and (= n 0) (cons? l)) (first l)]
    [(and (> n 0) (cons? l)) (list-pick (rest l) (sub1 n))]))


; -- simplifying the code we get
; list-pick: [List-of Symbol] N[>= 1] -> Symbol
; determines the nth symbol from alos, counting from 1;
; signals an error if there is no nth symbol
(define (list-pick alos n)
  (cond
    [(empty? alos) (error 'list-pick "list too short")]
    [(= n 0) (first alos)]
    [(> n 0) (list-pick (rest alos) (sub1 n))]))
