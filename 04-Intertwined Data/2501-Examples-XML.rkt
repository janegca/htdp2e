;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 2501-Examples-XML) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 25.01 - Examples - XML as S-expressions

; representing an XML element as a structure

(define-struct element.v0 [name])  ; <name />
; An Xexpr.v0 (short for X-expression) is 
;   (cons Symbol '())

(define-struct element.v1 [name content])   ; <name1> <name2 /> </name1>
; An Xexpr.v1 is 
;   (cons Symbol [List-of Xexpr.v1])

(define-struct element [name attributes content])
; An Xexpr.v2 is 
; – (cons Symbol [List-of Xexpr.v2])
; – (cons Symbol (cons [List-of Attribute] [List-of Xexpr.v2]))

(define-struct attribute [name value])
; An Attribute is 
;   (cons Symbol (cons String '()))

; -- Examples
; The following represents XML element:
;    <machine initial="red">
;        <action state="red"    next="green" />
;        <action state="green"  next="yellow" />
;        <action state="yellow" next="red" />
;    </machine>

(define ex1
  (make-element "machine" (list (make-attribute 'initial "red"))
  (list
    (make-element "action"
                  (list (make-attribute 'state "red")
                        (make-attribute 'next "green"))
                  '())
    (make-element "action"
                  (list (make-attribute 'state "green")
                        (make-attribute 'next "yellow"))
                  '())
    (make-element "action"
                  (list (make-attribute 'state "yellow")
                        (make-attribute 'next "green"))
                  '()))))

; the same, represented as an S-expr
(define ex2
  '(machine ((initial "red"))
          (action ((state "red") (next "green")))
          (action ((state "green") (next "yellow")))
          (action ((state "yellow") (next "red")))))

; S-expr examples using the Quote, Unquote mechanism
(define a0 '((initial "red")))
 
(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))

; Functions that work with Xexpr.v2

; Xexpr.v2 -> [List-of Attribute]
; retrieves the list of attributes of xe
(check-expect (xexpr-attributes e0) '())
(check-expect (xexpr-attributes e1) '((initial "red")))
(check-expect (xexpr-attributes e2) '())
(check-expect (xexpr-attributes e3) '())
(check-expect (xexpr-attributes e4) '((initial "red")))

(define (xexpr-attributes xe)
  (local ((define optional-loa+content (rest xe)))
    (cond
      [(empty? optional-loa+content) '()] ; no attribs or content
      [else (local ((define loa-or-x (first optional-loa+content)))
              (if (list-of-attributes? loa-or-x)
                  loa-or-x
                  '()))])))

; [List-of Attribute] or Xexpr.v2 -> Boolean
; is the given value a list of attributes
(define (list-of-attributes? x)
  (cond
    [(empty? x) #true]  ; empty list signals empty attribute list
    [else (local ((define possible-attribute (first x)))
            ; if the first element is a list, we have attributes
            (cons? possible-attribute))]))


