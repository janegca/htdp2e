;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-215-Bucket) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 215. Take a look at this data definition:

    ; A [Bucket ITEM] is 
    ;   (make-bucket N [List-of ITEM])
    ; interpretation the n in (make-bucket n l) is the length of l
    ;   i.e., (= (length l) n) is always true 

; When you instantiate Bucket with String, IR, and Posn, you get three 
; different data collections. Describe each of them with a sentence and 
; with two distinct examples.
;
; Now consider this instantiations:

    ; [Bucket [List-of [List-of String]]]

; Construct three distinct pieces of data that belong to this collection. 

(define-struct bucket [n lst])

; a [Bucket String] holds a list of strings and the length of the list
(make-bucket 1 (list "hello"))
(make-bucket 3 (list "hello" "and" "goodbye"))

; a [Bucket IR] holds a list of inventory records and the length of the list
(define-struct ir [n s])

(make-bucket 1 (list (make-ir "radios" 3)))
(make-bucket 2 (list (make-ir "cars" 1) (make-ir "trucks" 2)))

; a [Bucket Posn] holds a list of Posn's and the length of the list
(make-bucket 1 (list (make-posn 10 10)))
(make-bucket 2 (list (make-posn 10 10) (make-posn 20 20)))

; -- examples for [Bucket [List-of [List-of String]]]
; [List-of [List-of String] representes a list of string lists, so
(make-bucket 1 (list (list "hello")))
(make-bucket 2 (list (list "hello") (list "hello" "world")))
(make-bucket 3 (list (list "hello")
                     (list "hello" "world")
                     (list "goodbye" "bonsoir" "buenos noches")))