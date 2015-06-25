;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-350-replace-enum) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 350.
;
; Design a program that replaces all occurrences of "hello" with "bye" in an
; enumeration.

; -- XEnum definition
; An XItem.v2 is one of: 
; – (cons 'li (cons XWord '()))
; – (cons 'li (cons [List-of Attribute] (cons XWord '())))
; – (cons 'li (cons XEnum.v2 '()))
; – (cons 'li (cons [List-of Attribute] (cons XEnum.v2 '())))

; An XEnum.v2 is one of:
; – (cons 'ul [List-of XItem.v2])
; – (cons 'ul (cons [List-of Attribute] [List-of XItem.v2]))

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

; -- code for this exercise

; XExpr.v2 String String -> XExpr.v2
; replace every occurrence of the old word (old) in the enumeration (xe)
; with the new word (new)
(check-expect (replace-enum '(ul (li (word ((text "hello"))))) "hello" "bye")
              '(ul (li (word ((text "bye"))))))
(check-expect (replace-enum '(ul (li (word ((text "nada"))))) "hello" "bye")
              '(ul (li (word ((text "nada"))))))
(check-expect (replace-enum '(ul (li (word ((text "hello"))))
                                 (li (ul
                                      (li (word ((text "nada"))))
                                      (li (word ((text "hello")))))))
                            "hello" "bye")
              '(ul (li (word ((text "bye"))))
                   (li (ul
                        (li (word ((text "nada"))))
                        (li (word ((text "bye"))))))))

(define (replace-enum xe old new)
  (local ((define content (xexpr-content xe))
          (define (process-items item prev)
            (cons (mod-item item) prev))

          (define (mod-item elem)
            (local ((define item (first (xexpr-content elem))))
              (match item
                [`(word ((text ,value)))
                 (if (equal? value old)
                     `(li (word ((text ,new))))
                     (list 'li item))]
                [x (list 'li (replace-enum item old new))]))))
    
    (cons 'ul (foldr process-items '() content))))

