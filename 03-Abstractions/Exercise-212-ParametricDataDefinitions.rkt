;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-212-ParametricDataDefinitions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 212. 
; 
; A list of two items is another, frequently used form of data in ISL 
; programming. Here is data definition with two parameters:

    ; A [List X Y] is a structure: 
    ;   (cons X (cons Y '()))

; Instantiate this definition to retrieve
;
;    pairs of Numbers,
;
;    pairs of Numbers and 1Strings, and
;
;    pairs of Strings and Booleans.
;
; Also make one concrete example for each of these three data definitions.

; A [List Number Number] is a:
; (cons Number (cons Number '()))

(define np (list 5 10))

; A [List Number 1String] is a:
;   (cons Number (cons 1String '()))

(define n1 (list 5 "c"))

; A [List String Boolean] is a:
;   (cons String (cons Boolean '()))

(define sb (list "hello" true))

np
n1 
sb