;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-344-XWord) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 344.
;
; Make up three examples of XWords. Design the functions word?, which checks
; whether any ISL+ value is in XWord, and word-text, which extracts the value
; of the only attribute of an instance of XWord.

; An XWord is '(word ((text String)))

; -- Example XWord's
(define xw1 '(word ((text "hello"))))
(define xw2 '(word ((text "goodbye"))))
(define xw3 '(word ((text "jabberwocky"))))

(require 2htdp/abstraction)

; XExpr -> Boolean
; true if the xexpr is an XWord element
(check-expect (word? xw1) #true)
(check-expect (word? '((text "no"))) #false)

(define (word? xe)
  (match xe
    [(cons 'word rest) #true]
    [x #false]))
    
; XExpr -> String
; the XWord value
(check-expect (word-text xw1) "hello")
(check-expect (word-text xw2) "goodbye")
(check-expect (word-text xw3) "jabberwocky")
(check-expect (word-text '()) "")

(define (word-text xe)
  (match xe
    [`(word ((text ,value))) value]
    [x ""]))


