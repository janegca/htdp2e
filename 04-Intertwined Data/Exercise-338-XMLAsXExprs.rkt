;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-330-XMLAsXExprs) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 338. 
;
; Represent the following XML data as elements of Xexpr.v2:
;
; 1. <transition from="seen-e" to="seen-f" />
; 2. <ul><li><word /><word /></li><li><word /></li></ul>
; 3. <end></end>
;
; Which one could be represented in Xexpr.v0 or Xexpr.v1?

(define-struct element [name attributes content])
; An Xexpr.v2 is 
; – (cons Symbol Xexpr.v2*)
; – (cons Symbol (cons Attribute* Xexpr.v2*))

(define-struct attribute [name value])
; An Attribute is 
;   (cons Symbol (cons String '()))

; 1. <transition from="seen-e" to="seen-f" />
(define x1 (make-element "transition"
                         (list (make-attribute 'from "seen-e")
                               (make-attribute 'to   "seen-f"))
                         '()))
(define sx1 '(transition ((from "seen-e") (to "seen-f"))))

; 2. <ul><li><word /><word /></li><li><word /></li></ul>
(define x2
  (make-element 'ul
                '()
                (list (make-element 'li
                                    '()
                                    (list (make-element 'word '() '())
                                          (make-element 'word '() '())))
                      (make-element 'li
                                    '()
                                    (list (make-element 'word '() '()))))))
(define sx2 '(ul 
              (li (word word))
              (li (word))))

; 3. <end></end>
(define x3 (make-element 'end '() '()))
(define sx3 '(end))

; Ans:
;    x3 could be represented by Xexpr.v0 and Xexpr.v1
;    x2 could be represented by Xexpr.v1


