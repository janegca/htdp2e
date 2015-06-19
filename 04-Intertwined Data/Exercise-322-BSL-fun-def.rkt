;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-318-BSL-fun-def) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 322.
; 
; Provide a structure type definition and a data definition for function 
; definitions. Recall that a function definition has three essential 
; attributes:
;
; 1. the function’s name,
; 2. the function’s parameter, which is also a name, and
; 3. the function’s body, which is a variable expression that usually 
;    contains the parameter.
;
; We use BSL-fun-def to refer to the class of data representations for
; function definitions.
;
; Use your data definition to represent the following BSL function definitions:
;
;    (define (f x) (+ 3 x))
;    (define (g y) (f (* 2 y)))
;    (define (h v) (+ (f v) (g v)))
;
; Next, define the class BSL-fun-def* to represent definitions area that
; consist of just one-argument function definitions. Translate the 
; definitions area that defines f, g, and h into your data representation
; and name it da-fgh.
;
; Finally, design the function lookup-def with the following header:

    ; BSL-fun-def* Symbol -> BSL-fun-def
    ; retrieves the definition of f in da 
    ; or signal "undefined function" if da does not contain one
    ;(check-expect (lookup-def da-fgh 'g) g)
    ;(define (lookup-def da f) ...)

; Looking up a definition is needed for the evaluation of expressions in
; BSL-fun-expr.

(define-struct def [name param body])
; BSL-fun-def is a structure: (make-def Symbol Symbol BSL-fun-expr)
; interpretation: (make-def n p b) combines the three elements of
; a function definition: name (n), parameter (p) and body (b)
  
(define-struct fun [name arg])
; Fun is a structure: (make-fun Symbol  BSL-fun-expr)

(define-struct add [left right])
; Add is a structure: (make-add BSL-fun-expr BSL-fun-expr)

(define-struct mul [left right])
; Mul is a structure: (make-mul BSL-fun-expr BSL-fun-expr)  
  
;-- Example function definitions
; (define (f x) (+ 3 x))
(define f (make-def 'f 'x (make-add 3 'x)))

; (define (g y) (f (* 2 y)))
(define g (make-def 'g 'y (make-fun 'f (make-mul 2 'y))))

; (define (h v) (+ (f v) (g v)))
(define h (make-def 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v))))

; BSL-fun-def* is one-of:
; - '()
; - [List-of def]

(define da-fgh (list f g h))

; BSL-fun-def* Symbol -> BSL-fun-def
; retrieves the definition of f in da 
; or signal "undefined function" if da does not contain one
(check-expect (lookup-def da-fgh 'g) g)
(check-error  (lookup-def da-fgh 'k))

(define (lookup-def da f)
  (cond [(empty? da) (error "undefined function")]
        [(eq? f (def-name (first da))) (first da)]
        [else (lookup-def (rest da) f)]))

