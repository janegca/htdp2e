;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-213-AbstractingDataDefintions) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 213. Here are two strange but similar data definitions:

    ; A Nested-string is one of: 
    ; – String
    ; – (make-layer Nested-string)
    	
    ; A Nested-number is one of: 
    ; – Number
    ; – (make-layer Nested-number)

; Both data definitions exploit this structure type definition:
;
    (define-struct layer [stuff])

; Both define nested forms of data, one is about numbers and the other about 
; strings. Make examples for both. Abstract over the two. Then instantiate 
; the abstract definition to get back the originals.

; -- examples
(define ns "hello")
(define ns1 (make-layer "hello"))

(define nn 1)
(define nn2 (make-layer 1))

; A [Nested ITEM] is one of:
; - ITEM
; - (make-layer Nested-ITEM)

; A [Nested String] is one of:
; - String
; - (make-layer [Nested String])

; A [Nested Number] is one of:
; - Number
; - (make-layer [Nested Number])

