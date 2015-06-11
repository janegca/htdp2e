;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-269-count-persons) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 269. 
; 
; Develop count-persons. The function consumes a family tree node and counts
; the child structures in the tree. 

; -- data structures
(define-struct no-parent [])
(define-struct child [father mother name date eyes])

(define MTFT (make-no-parent))


; -- example family tree

; oldest generation
(define Carl    (make-child MTFT MTFT "Carl" 1926 "green"))
(define Bettina (make-child MTFT MTFT "Bettina" 1925 "green"))

; middle generation
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva  (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child MTFT MTFT "Fred" 1966 "pink"))

; youngest generation
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

; FT -> Number
; count the number of people in a family tree
(check-expect (count-persons MTFT)   0)
(check-expect (count-persons Carl)   1)
(check-expect (count-persons Gustav) 5)

(define (count-persons ft)
  (cond [(no-parent? ft) 0]
        [ else (+ 1 (count-persons (child-father ft))
                    (count-persons (child-mother ft)))]))
