;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-131-SortedList) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 131. 
; Design sorted>?. The function consumes a NEList-of-temperatures.
; It produces #true if the temperatures are sorted in descending order, 
; that is, if the second is smaller than the first, the third smaller than
; the second, and so on. Otherwise it produces #false.

; NEList-of-temperatures -> Boolean
; returns true if a list of temperatures is sorted in 
; descending order
(check-expect (sorted>? (cons 3(cons 2(cons 1 '())))) true)
(check-expect (sorted>? (cons 1(cons 2(cons 3 '())))) false)

(define (sorted>? nel) 
  (cond
    [(empty? (rest nel)) true]
    [(cons?  (rest nel))
     (cond [(> (first nel) (first (rest nel))) (sorted>? (rest nel))]
           [else false])]))
     