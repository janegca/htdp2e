;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-317-eval-definition1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 321.
; 
; Design eval-definition1. The function is given an expression (representation)
; in the extended data definition of exercise 320 and the one function
; definition that is assumed to exist in the definitions area. It evaluates
; the given expression and returns its value.
;
; Specification, eval-definition1 consumes four arguments:
;
; 1. a BSL-fun-expr e;
; 2. a symbol f, which represents a function name;
; 3. a symbol x, which represents the functions’s parameter; and
; 4. a BSL-fun-expr b, which represents the function’s body.
;
; If the terminology poses any difficulties, do re-read BSL: Grammar.
;
; To determine the value of e, the function proceeds as before. When it
; encounters an application of f to some argument,
;
; 1. eval-definition1 evaluates the argument,
; 2. substitutes the value of the argument for x in b; and
; 3. finally evaluates the resulting expression with eval-definition1.
;
; Here is how to express the steps as code, assuming arg is the argument of 
; the function application:
;
;    (eval-definition1 (subst b x (eval-definition1 arg f x b)) f x b)
;
; Notice that this line uses a form of recursion that you have not encountered
; so far. The proper design of such functions is discussed in Generative 
; Recursion.
;
; If eval-definition1 encounters a variable, it signals the same error as 
; eval-variable from exercise 316. Also, for function applications that do 
; not refer to f, eval-definition1 signals an error as if it had encountered a variable.
;
; Warning The use of generative recursion introduces a new element into your
; computations: non-termination. That is, given some argument, a program may
; not deliver a result or signal an error but run forever. For fun, you may
; wish to construct an input for eval-definition1 that causes it to run
; forever. Use STOP to terminate the program. 

; -- from Exercise 320

; A BSL-fun-expr is one of: 
; – Number
; – Symbol 
; - (make-fun name         BSL-fun-expr)
; – (make-add BSL-fun-expr BSL-fun-expr)
; – (make-mul BSL-fun-expr BSL-fun-expr)

; -- Structures
(define-struct fun [name arg])
; Fun is a structure: (make-fun Symbol  BSL-fun-expr)

(define-struct add [left right])
; Add is a structure: (make-add BSL-fun-expr BSL-fun-expr)

(define-struct mul [left right])
; Mul is a structure: (make-mul BSL-fun-expr BSL-fun-expr)

; -- Example Functions based on Exercise 315
(define f1 (make-fun 'k  (make-add 1 1)))
(define f2 (make-mul  5  f1))
(define f3 (make-mul (make-fun 'i 5) f1))
  
; -- Error messages
(define ERR_FN_EXPR "invalid function expression")
(define ERR_EXPR    "invalid expression")

; -- Functions

; BSL-fun-expr Symbol Symbol BSL-fun-expr -> Number
; the value of the BSL-fun-expr, if possible, otherwise an error       
(check-expect (eval-def1 f1 'k 'a (make-mul 'a 'a)) 4)
(check-expect (eval-def1 f1 'k 'a (make-add 'a  5)) 7)
(check-expect (eval-def1 f2 'k 'a (make-add 'a 'a)) 20)
(check-error  (eval-def1 f3 'k 'a (make-add 'a 'a)) ERR_FN_EXPR)
(check-error  (eval-def1 f1 'k 'a (make-add 'a 'b)) ERR_EXPR)
(check-error  (eval-def1 (make-add 'x 1) 'k 'a (make-add 'a 'a)) ERR_EXPR)

(define (eval-def1 e f x b)
  (cond [(number? e) e]
        [(fun?    e)
         (if (eq? f (fun-name e))
             (eval-def1 (subst b x (eval-def1 (fun-arg e) f x b)) f x b)
             (error ERR_FN_EXPR))]
        [(add? e)
         (+ (eval-def1 (add-left e)  f x b)
            (eval-def1 (add-right e) f x b))]
        [(mul? e)
         (* (eval-def1 (mul-left e)  f x b)
            (eval-def1 (mul-right e) f x b))]
        [else (error ERR_EXPR)]))
                 
; -- from Exercise 309 
; BSL-var-expr Symbol Number -> BSL-var-expr
; replaces all symbol values in the expression with the number value
(define (subst e x v)
  (cond [(number? e) e]
        [(symbol? e) (if (eq? e x) v e)]
        [(add?    e) (make-add (subst (add-left e)  x v)
                               (subst (add-right e) x v))]
        [(mul?    e) (make-mul (subst (mul-left e)  x v)
                               (subst (mul-right e) x v))]))
