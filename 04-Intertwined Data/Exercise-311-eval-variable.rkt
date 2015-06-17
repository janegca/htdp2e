;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-311-eval-variable) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 311. 
;
; Design eval-variable. The function consumes a BSL-var-expr and determines 
; its value if numeric? is true. Otherwise it signals an error, saying that 
; it is impossible to evaluate an expression that contains a variable.
;
; In general, a program defines many constants in the definitions area and 
; expressions contain more than one variable. To evaluate such expressions,
; we need a representation of the definition area when it contains a series 
; of constant definitions. For this exercise we use association lists:

    ; An AL (association list) is [List-of Association].
    ; An Association is (cons Symbol (cons Number '())).

; Make up elements of AL.
;
; Design eval-variable*. The function consumes a BSL-var-expr e and an
; association list da. Starting from e, it iteratively applies subst to all 
; associations in da. If numeric? holds for the result, it determines its
; value; otherwise it signals the same error as eval-variable. 
; 
; Hint: Think of the given BSL-var-expr as an atomic value and traverse the 
;       given association list instead. Or use a loop from figure 56. We 
;       provide this hint because the creation of this function requires a
;       little design knowledge from Simultaneous Processing.

; -- From Exercise 310

; A BSL-expr is one of: 
; – Number
; – (make-add BSL-expr BSL-expr)
; – (make-mul BSL-expr BSL-expr

; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

; -- Structures
(define-struct add [left right])
(define-struct mul [left right])

; [Maybe BSL-var-expr] -> Boolean
; true if the expression has no symbols (variables)
(define (numeric? e)
  (cond [(symbol? e) #false]
        [(number? e) #true]
        [(add? e) (and (numeric? (add-left e))
                       (numeric? (add-right e)))]
        [(mul? e) (and (numeric? (mul-left e))
                       (numeric? (mul-right e)))]))

; -- eval-expression from Exercise 306

; BSL-expr -> BSL-value
(define (eval-expr bexpr)
  (cond [(number? bexpr) bexpr]
        [(add?    bexpr) 
         (+ (eval-expr (add-left bexpr)) (eval-expr (add-right bexpr)))]
        [(mul?    bexpr)
         (* (eval-expr (mul-left bexpr)) (eval-expr (mul-right bexpr)))]))

; -- subst function from Exercise 309

; BSL-var-expr Symbol Number -> BSL-var-expr
; replaces all symbol values in the expression with the number value
(define (subst e x v)
  (cond [(number? e) e]
        [(symbol? e) (if (eq? e x) v e)]
        [(add?    e) (make-add (subst (add-left e)  x v)
                               (subst (add-right e) x v))]
        [(mul?    e) (make-mul (subst (mul-left e)  x v)
                               (subst (mul-right e) x v))]))
; BSL-var-expr -> Number
; the value of a variable expression, if it is numeric
(check-expect (eval-variable 3) 3)
(check-error  (eval-variable 'x))

(check-expect (eval-variable (make-add 5 3))  8)
(check-expect (eval-variable (make-mul 5 3)) 15)
(check-error  (eval-variable (make-add 'x 3)))
(check-error  (eval-variable (make-mul 5 'y)))

(define (eval-variable e)
  (cond [(not (numeric? e)) 
         (error "impossible to evaluate non-numeric expression")]
        [ else (eval-expr e)]))

; -- Example Association Lists
(define al-x  '((x 5)))
(define al-xy '((x 5) (y 3)))

; -- Example BSL-var-expressions
(define e1 'x)
(define e2 (make-add 'x 3))
(define e3 (make-mul 1/3 (make-mul 'x 3)))
(define e4 (make-add (make-mul 'x 'x)
                     (make-mul 'y 'y)))

; BSL-var-expr AL -> Number
; the expression's value given the associated variable list, if
; the variable substitution matches and produces a numeric expression
(check-expect (eval-variable* 3  al-x) 3)
(check-expect (eval-variable* e1 al-x) 5)
(check-expect (eval-variable* e2 al-x) 8)
(check-expect (eval-variable* e3 al-x) 5)
(check-expect (eval-variable* e4 al-xy) 34)

(define (eval-variable* e a*)
  (cond [(empty? a*) (eval-expr e)]
        [else (eval-variable* 
               (subst e (first (first a*)) (second (first a*)))
               (rest a*))]))
        
