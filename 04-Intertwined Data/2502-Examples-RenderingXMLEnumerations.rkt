;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 2502-Examples-RenderingXMLEnumerations) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 25.02 Examples - Rendering XML Enumerations

; An XWord is '(word ((text String)))

; An XEnum.v1 is one of: 
; – (cons 'ul [List-of XItem.v1])
; – (cons 'ul (cons [List-of Attribute] [List-of XItem.v1]))

; An XItem.v1 is one of:
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons [List-of Attribute] (cons XWord '())))

; An XWord is '(word ((text String)))

(define e0
  '(ul
    (li (word ((text "one"))))
    (li (word ((text "two"))))))

; -- functions from earlier exercises used in the examples
(require 2htdp/abstraction)

(define (xexpr-content xe)
  (match xe
    [(cons n '()) '()]               ; no optional values
    [(cons n (cons '() rest)) rest]  ; empty attribute list
    [(cons n (cons a rest))          ; one or more optional values
     (if (list? (first a))           ; is the first an attrib list?
         rest                        ; yes
         (cons a rest))]))           ; no, so recombine

(define (word-text xe)
  (match xe
    [`(word ((text ,value))) value]
    [x ""]))

; Examples

(require 2htdp/image)

(define SPACER (square 2 'solid 'white))
(define BULLET (beside/align 'center (circle 2 'solid 'black) SPACER))

(define item1-rendered
  (beside/align 'center BULLET (text "one" 12 'black)))

(define item2-rendered
  (beside/align 'center BULLET (text "two" 12 'black)))

(define e0-rendered
  (above/align 'left item1-rendered item2-rendered))

; XItem.v1 -> Image 
; renders a single item as a "word" prefixed by a bullet
(define (render-item1 i)
  (local ((define content (xexpr-content i))
          (define element (first content))
          (define word-in-i (word-text element)))
    (beside/align 'center BULLET (text word-in-i 12 'black))))

; representing the UL XHTML element as an enumeration
(define (render-enum1 xe)
  (local ((define content (xexpr-content xe))
          ; XItem.v1 Image -> Image 
          (define (deal-with-one-item fst-itm so-far)
            (above/align 'left (render-item1 fst-itm) so-far)))
    (foldr deal-with-one-item empty-image content)))





