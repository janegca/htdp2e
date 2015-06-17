;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-309-subst) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 309. 
; 
; Design subst. The function consumes a BSL-var-expr e, a Symbol x, and a 
; Number v. It produces a BSL-var-expr like e with all occurrences of x
; replaced by v. 

; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

; -- Structures
(define-struct add [left right])
(define-struct mul [left right])

; BSL-var-expr Symbol Number -> BSL-var-expr
; replaces all symbol values in the expression with the number value
(check-expect (subst  3  'x 5) 3)
(check-expect (subst 'x  'x 5) 5)
(check-expect (subst (make-add 'x 3) 'x 5)
              (make-add 5 3))
(check-expect (subst (make-add 5 'y) 'y 3)
              (make-add 5 3))
(check-expect (subst (make-add 'x 3) 'y 3) 
              (make-add 'x 3))
(check-expect (subst (make-mul 'x 3) 'x 5)
              (make-mul 5 3))
(check-expect (subst (make-mul 5 'y) 'y 3)
              (make-mul 5 3))
(check-expect (subst (make-mul 5 'y) 'x 5)
              (make-mul 5 'y))
(check-error (subst '() 'x 5))

(check-expect (subst (make-add 'x 'x) 'x 5)
              (make-add 5 5))
(check-expect (subst (make-mul 'y 'y) 'y 3)
              (make-mul 3 3))

(check-expect (subst (make-mul 1/3 (make-mul 'x 3)) 'x 5)
              (make-mul 1/3 (make-mul 5 3)))

; Solution ref:
;      http://www.htdp.org/2003-09-26/Solutions/scheme-subst.html
(define (subst e x v)
  (cond [(number? e) e]
        [(symbol? e) (if (eq? e x) v e)]
        [(add?    e) (make-add (subst (add-left e)  x v)
                               (subst (add-right e) x v))]
        [(mul?    e) (make-mul (subst (mul-left e)  x v)
                               (subst (mul-right e) x v))]))
                                      
