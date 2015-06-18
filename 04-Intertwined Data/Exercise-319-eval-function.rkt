;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-319-eval-function) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 319. 
;
; Design eval-function*. The function consumes the BSL-fun-expr representation
; of some expression e and the BSL-fun-def* representation of a definitions 
; area da. It produces the result that DrRacket shows if you evaluate e in 
; the interactions area assuming the definitions area contains da.
;
; The function works like eval-function1 from exercise 317. For an application
; of some function f, it
;
; 1. evaluates the argument;
; 2. looks up the definition of f in the BSL-fun-def representation of da;
; 3. substitutes the value of the argument for the function parameter in the
;    function’s body; and
; 4. evaluates the new expression via recursion.
;
; Remember that the representation of a function definition for f comes with 
; a parameter and a body.
; 
; Like DrRacket, eval-function* signals an error when it encounters a variable
; or an application whose function is not defined in the definitions area.

; NOTE: needed to modify 'subst' to include a fun? condition

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

; bad function definition
(define k (make-def 'k 'z (make-add 2 'x)))

(define da-fghk (list f g h k))

; -- Example functions
(define e1 (make-fun 'f 3))
(define e2 (make-fun 'g 3))
(define e3 (make-fun 'h 3))
(define e4 (make-fun 'k 3))

; -- Error messages
(define ERR_EXPR     "invalid expression")
(define ERR_FN_UNDEF "undefined function")

; BSL-fun-expr BSL-fun-def* -> Number
; the value of e assuming all functions defined within e are available
; in da; otherwise, an error
(check-expect (eval-function e1 da-fghk)  6)
(check-expect (eval-function e2 da-fghk)  9)
(check-expect (eval-function e3 da-fghk) 15)
(check-error  (eval-function (make-fun 'm 3) da-fghk) ERR_FN_UNDEF)
(check-error  (eval-function e4 da-fghk)  ERR_EXPR)

(define (eval-function e da)
  (cond [(number? e) e]
        [(fun?    e)
         (local (; the function definition, if found, otherwise an error
                 (define fd (lookup-def da (fun-name e)))
                   
                 (define arg (fun-arg    e))
                 (define b   (def-body  fd))
                 (define x   (def-param fd)))
           (eval-function (subst b x (eval-function arg da)) da))]
        [(add? e)
         (+ (eval-function (add-left  e) da)
            (eval-function (add-right e) da))]
        [(mul? e)
         (* (eval-function (mul-left  e) da)
            (eval-function (mul-right e) da))]
        [else (error ERR_EXPR)]))
 
; BSL-fun-def* Symbol -> BSL-fun-def
; retrieves the definition of f in da 
; or signal "undefined function" if da does not contain one
(define (lookup-def da f)
  (cond [(empty? da) (error ERR_FN_UNDEF)]
        [(eq? f (def-name (first da))) (first da)]
        [else (lookup-def (rest da) f)]))

; BSL-var-expr Symbol Number -> BSL-var-expr
; replaces all symbol values in the expression with the number value
(define (subst e x v)
  (cond [(number? e) e]
        [(symbol? e) (if (eq? e x) v e)]
        [(fun?    e) (make-fun (fun-name e) (subst (fun-arg e) x v))]
        [(add?    e) (make-add (subst (add-left e)  x v)
                               (subst (add-right e) x v))]
        [(mul?    e) (make-mul (subst (mul-left e)  x v)
                               (subst (mul-right e) x v))]))


  
  