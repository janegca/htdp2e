;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-346-render-item1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 346.
;
; Before you read on, equip the definition of render-item1 with at least one
; test; make sure that the tests are formulated so that they don’t truly
; depend on the nature of BULLET. Then explain how the function works; keep
; in mind that the purpose statement explains only what it does.

; -- functions from exercises
(require 2htdp/abstraction)

; Xexpr.v2 -> [List-of Xexpr.v2]
; retrieves the list of contents for xe

(define (xexpr-content xe)
  (match xe
    [(cons n '()) '()]                       ; no optional values
    [(cons n (cons a '()))
     (if (list? (first a)) '() `(,a))]       ; one optional value
    [(cons n (cons a rest)) rest]))          ; both optional values

; XExpr -> String
; the XWord value
(define (word-text xe)
  (match xe
    [`(word ((text ,value))) value]
    [x ""]))

; -- function, defintions from example

(define e0
  '(ul
    (li (word ((text "one"))))
    (li (word ((text "two"))))))

(require 2htdp/image)

(define SPACER (square 2 'solid 'white))
(define BULLET (beside/align 'center (circle 2 'solid 'black) SPACER))

; XItem.v1 -> Image 
; renders a single item as a "word" prefixed by a bullet
(check-expect (render-item1 '(li (word ((text "one")))))
              (beside/align 'center BULLET (text "one" 12 'black)))

(define (render-item1 i)
  (local ((define content   (xexpr-content i))
          (define element   (first content))
          (define word-in-i (word-text element)))
    (beside/align 'center BULLET (text word-in-i 12 'black))))

; render-item1
; a. extracts the contents from the list item XExpr
; b. extracts the first item from the content, which is an XWord
; c. extracts the text of the XWord
; d. creates and displays an image of the list item with a bullet
;    and text associated with the list item

