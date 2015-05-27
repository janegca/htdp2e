;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-206-ContainsFn) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 206. 
; 
; Use contains? to define functions that search for "atom", "basic", 
; and "zoo", respectively. 

; String Los -> Boolean
; determines whether l contains the string s
(check-expect (contains? "hat" '()) false)
(check-expect (contains? "hat" (list "cat" "mouse" "hat")) true)

(define (contains? s l)
  (cond
    [(empty? l) #false]
    [else (or (string=? (first l) s)
              (contains? s (rest l)))]))

; Los -> Boolean
; does los contain "atom"
(check-expect (contains-atom? (list "hat" "mouse" "deer")) false)

(define (contains-atom? los)
  (contains? "atom" los))

; Los -> Boolean
; does los contain "basic"
(check-expect (contains-basic? (list "hat" "coat" "basic" "shoes")) true)

(define (contains-basic? los)
  (contains? "basic" los))

; Los -> Boolean
; does los contain "zoo"?
(check-expect (contains-zoo? (list "mouse" "zoo" "cat")) true)

(define (contains-zoo? los)
  (contains? "zoo" los))