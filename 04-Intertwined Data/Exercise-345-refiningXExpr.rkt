;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-345-refiningXExpr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 345.
;
; Refine the definition of Xexpr.v2 so that an you can represent XML
; elements that are plain strings. Use this refinement to represent
; enumerations.

; An Xexpr.v2 is 
; – (cons Symbol [List-of Xexpr.v2])
; – (cons Symbol (cons [List-of Attribute]] [List-of Xexpr.v2]))

; An Attribute is 
;   (cons Symbol (cons String '()))

; An XWord is an XExpr of the form:
;    '(word ((text String)))


'(ul
  (li (word ((text "hello"))))
  (li (word ((text "goodbye")))))

