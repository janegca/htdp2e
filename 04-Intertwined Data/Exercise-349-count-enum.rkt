;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-349-count-enum) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 349.
;
; Design a program that counts all occurrences of "hello" in an instance of
; XEnum.v2.


; -- functions from earlier exercises
(require 2htdp/abstraction)

(check-expect (xexpr-content '(machine)) '())
(check-expect (xexpr-content `(machine () (action))) '((action)))
(check-expect (xexpr-content `(machine ((attrib "test")) (action) (action)))
              '((action) (action)))

(define (xexpr-content xe)
  (match xe
    [(cons n '()) '()]               ; no optional values
    [(cons n (cons '() rest)) rest]  ; empty attribute list
    [(cons n (cons a rest))          ; one or more optional values
     (if (list? (first a))           ; is the first an attrib list?
         rest                        ; yes
         (cons a rest))]))           ; no, so recombine

; -- XEnum definition
; An XItem.v2 is one of: 
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons [List-of Attribute] (cons XWord '())))
; – (cons 'li (cons XEnum.v2 '()))
; – (cons 'li (cons [List-of Attribute] (cons XEnum.v2 '())))

; An XEnum.v2 is one of:
; – (cons 'ul [List-of XItem.v2])
; – (cons 'ul (cons [List-of Attribute] [List-of XItem.v2]))

; -- code for this exercise
; XExpr.v2 String -> Number
; count the number of times the word (w) appears in the enumeration (xe)
(check-expect (count-enum '(ul (li (word ((text "hello"))))) "hello") 1)
(check-expect (count-enum '(ul (li (word ((text "nada"))))) "hello")  0)
(check-expect (count-enum '(ul (li (word ((text "hello"))))
                               (li (ul (li (word ((text "hello")))))))
                          "hello") 2)

(define (count-enum xe w)
  (local ((define content (xexpr-content xe))
          (define (process-items item count)
            (+ count (item-value item)))

          (define (item-value elem)
            (local ((define item (first (xexpr-content elem))))
              (match item
                [`(word ((text ,value)))
                 (if (equal? value w) 1 0)]
                [x (count-enum elem w)]))))
    
    (foldr process-items 0 content)))

            