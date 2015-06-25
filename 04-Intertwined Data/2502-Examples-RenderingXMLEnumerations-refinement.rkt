;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 2502-Examples-RenderingXMLEnumerations-refinement) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 2502-Example-Refining Rendering XML Enumerations

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

(define (word? xe)
  (match xe
    [(cons 'word rest) #true]
    [x #false]))


; changing the data defintions and functions to handle nested lists

; An XItem.v2 is one of: 
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons [List-of Attribute] (cons XWord '())))
; – (cons 'li (cons XEnum.v2 '()))
; – (cons 'li (cons [List-of Attribute] (cons XEnum.v2 '())))

; An XEnum.v2 is one of:
; – (cons 'ul [List-of XItem.v2])
; – (cons 'ul (cons [List-of Attribute] [List-of XItem.v2]))

(require 2htdp/image)

(define SIZE 12)
(define COLOR 'black)
(define BULLET
  (beside (circle 1 'solid 'black) (text " " SIZE COLOR)))
 
; Image -> Image
; marks item with bullet  
(define (bulletize item)
  (beside/align 'center BULLET item))
 
(define e0
  '(ul
    (li (word ((text "one"))))
    (li (word ((text "two"))))))

(define item1-rendered
  (beside/align 'center BULLET (text "one" 12 'black)))

(define item2-rendered
  (beside/align 'center BULLET (text "two" 12 'black)))

(define e0-rendered
  (above/align 'left item1-rendered item2-rendered))

 
; XEnum.v2 -> Image
; renders an XEnum.v2 as an image 
 
(check-expect (render-enum e0) e0-rendered)
 
(define (render-enum an-enum)
  (local ((define content (xexpr-content an-enum))
          ; XItem.v2 Image -> Image 
          (define (deal-with-one-item fst-itm so-far)
            (above/align 'left (render-item fst-itm) so-far)))
    (foldr deal-with-one-item empty-image content)))
 
; XItem.v2 -> Image
; renders one XItem.v2 as an image 
 
(check-expect
  (render-item '(li (word ((text "one")))))
  (bulletize (text "one" SIZE COLOR)))
 
(check-expect (render-item `(li ,e0)) (bulletize e0-rendered))
 
(define (render-item an-item)
  (local ((define content (first (xexpr-content an-item))))
    (beside/align
     'center BULLET
     (cond
       [(word? content) (text (word-text content) SIZE 'black)]
       [else (render-enum content)]))))
