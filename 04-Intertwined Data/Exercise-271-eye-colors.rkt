;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-271-eye-colors) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 271. 
;
; Develop the function eye-colors, which consumes a family tree node and 
; produces a list of all eye colors in the tree. An eye color may occur more 
; than once in the resulting list.
;
; Hint: Use the append operation to concatenate lists.

; -- data structures
(define-struct no-parent [])
(define-struct child [father mother name date eyes])

(define MTFT (make-no-parent))


; -- example family tree

; oldest generation
(define Carl    (make-child MTFT MTFT "Carl"    1926 "green"))
(define Bettina (make-child MTFT MTFT "Bettina" 1925 "green"))

; middle generation
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva  (make-child Carl Bettina "Eva"  1965 "blue"))
(define Fred (make-child MTFT MTFT "Fred"    1966 "pink"))

; youngest generation
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

; FT -> [List-of String]
; return the eye colors of all persons in the family tree
(check-expect (eye-colors MTFT)    '())
(check-expect (eye-colors Bettina) '("green"))
(check-expect (eye-colors Eva)     '("blue" "green" "green"))

(define (eye-colors ft)
  (cond [(no-parent? ft) '()]
        [else (append (list (child-eyes ft))
                      (eye-colors (child-father ft))
                      (eye-colors (child-mother ft)))]))

