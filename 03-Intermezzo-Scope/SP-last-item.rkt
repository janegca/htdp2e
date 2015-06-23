;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname SP-last-item) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Sample Problem:
;
; Design the function last-item, which retrieves the last item on a
; non-empty list. Recall that non-empty lists are defined as follows:

    ; A [Non-empty-list X] is one of: 
    ; – (cons X '())
    ; – (cons X [Non-empty-list X])

(require 2htdp/abstraction)

; [Non-empty-list X] -> X
; retrieve the last item of ne-l 
(check-expect (last-item '(a b c)) 'c)
(check-error (last-item '()))

(define (last-item ne-l)
   (match ne-l
     [(cons lst '()) lst]
     [(cons fst rst) (last-item rst)]))
