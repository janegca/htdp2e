;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-326-BSL-da-all) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 326. 
;
; Formulate a data definition for the representation of DrRacket’s definition
; area. Concretely, the data representation should work for a sequence that 
; freely mixes constant definitions and one-argument function definitions. 
; Make sure you can represent the definitions area consisting of three 
; definitions at the beginning of this section.—We use BSL-da-all for this 
; class of data.
;
; Design the function lookup-con-def, It consumes a BSL-da-all da and a symbol
; x. It produces the representation of a constant definition whose name is x, 
; if such a piece of data exists in da; otherwise the function signals an
; error saying that no such constant definition can be found.
;
; Design the function lookup-fun-def, It consumes a BSL-da-all da and a symbol
; f. It produces the representation of a function definition whose name is f,
; if such a piece of data exists in da; otherwise the function signals an error
; saying that no such function definition can be found.

; BSL-da-all is one of:
; - '()
; - [List-of [BSL-fun-def BSL-const-def]]

(define-struct const [name value])
; BSL-const-def is a structure: (make-const Symbol BSL-fun-expr)
; interpretation: (make-const n v) combines the two elements of
; a constant definiton: name (n) and value (v)
 
; required structures from earlier exercises

(define-struct def [name param body])
; BSL-fun-def is a structure: (make-def Symbol Symbol BSL-fun-expr)
; interpretation: (make-def n p b) combines the three elements of
; a function definition: name (n), parameter (p) and body (b)

(define-struct fun [name arg])
(define-struct mul [left right])
  
; -- Examples
(define c1 (make-const 'close-to-pi 3.14))
(define f1 (make-def 'area-of-circle 'r
                     (make-mul (make-const 'close-to-pi 3.14)
                               (make-mul 'r 'r))))

(define da-all (list c1 f1))

; -- Functions

; BSL-da-all Symbol -> Const
; the constant data definition whose name matches x, if found, 
; otherwise, an error
(check-expect (lookup-con-def da-all 'close-to-pi)
              (make-const 'close-to-pi 3.14))
(check-error  (lookup-con-def da-all 'no-such-const))

(define (lookup-con-def da x)
  (cond [(empty? da) (error "constant definition not found")]
        [(and (const? (first da))
              (eq? x (const-name (first da)))) (first da)]
        [else (lookup-con-def (rest da) x)]))
  
; BSL-da-all Symbol -> Def
; the function definition whose name matches f, if found,
; otherwise, an errror
(check-expect (lookup-fun-def da-all 'area-of-circle)
              (make-def 'area-of-circle 'r
                     (make-mul (make-const 'close-to-pi 3.14)
                               (make-mul 'r 'r))))
(check-error  (lookup-fun-def da-all 'no-fun-found))
              
(define (lookup-fun-def da f)
  (cond [(empty? da) (error "function definition not found")]
        [(and (def? (first da))
              (eq? f (def-name (first da)))) (first da)]
        [else (lookup-fun-def (rest da) f)]))