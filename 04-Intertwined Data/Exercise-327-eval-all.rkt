;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-327-eval-all) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 327. 
; 
; Design eval-all. Like eval-function* from exercise 323, this function
; consumes the representation of an expression and of a definitions area.
; It produces the same value that DrRacket shows if the expression is entered 
; at the prompt in the interactions area and the definitions area contains the 
; appropriate definitions. 
;
; Hint: Your eval-all function should process variables in the given
;       expression like eval-var-lookup in exercise 319. 

; NOTE: this only handle functions with one param
;       doesn't handle add? or fun? (not part of examples)
;       TODO - re-work it

; -- Code from earlier exercises
(define-struct const [name value])
(define-struct def [name param body])
(define-struct fun [name arg])
(define-struct add [left right])
(define-struct mul [left right])

; -- Example defintions
(define d1 (make-const 'close-to-pi 3.14))
(define d2 (make-def   'area-of-circle 'r
                       (make-mul 'close-to-pi
                               (make-mul 'r 'r))))

(define da-all (list d1 d2))

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
                        (make-mul 'close-to-pi (make-mul 'r 'r))))
(check-error  (lookup-fun-def da-all 'no-fun-found))

(define (lookup-fun-def da f)
  (cond [(empty? da) (error "function definition not found")]
        [(and (def? (first da))
              (eq? f (def-name (first da)))) (first da)]
        [else (lookup-fun-def (rest da) f)]))

;-- code for this exercise
; BSL-expr BSL-da-all -> Number
; the value of the given expression, if possible
(check-expect (eval-all 'close-to-pi da-all) 3.14)
(check-expect (eval-all (make-fun 'area-of-circle 3) da-all) 28.26)

(define (eval-all expr da)
  (local (; will need some
          (define (eval-expr e)
            (cond [(number? e) e]
                  [(fun?    e)
                   (local ((define fd (lookup-fun-def da (fun-name e)))
                           (define arg (fun-arg e))
                           (define b   (eval-constants da (def-body fd)))
                           (define x   (def-param fd)))
                     (eval-expr (subst b x (eval-expr arg))))]     
                  [(mul? e)
                   (* (eval-expr (mul-left  e))
                      (eval-expr (mul-right e)))])
          ))
    ; -- IN --
    (if (symbol? expr) 
        (const-value (lookup-con-def da expr))
        (eval-expr expr))))

(define (eval-constants da e)
  (local ((define (get-value c)
            (if (symbol? c)
                (const-value (lookup-con-def da c))
                c)))
  (cond [(mul? e) 
          (make-mul (get-value (mul-left e))
                    (get-value (mul-right e)))]
        [else e])))

; BSL-fun-expr Symbol Number -> BSL-fun-expr
; replaces all symbol values in the expression with the number value
(define (subst e x v)
  (cond [(number? e) e]
        [(symbol? e) (if (eq? e x) v e)]       
        [(mul?    e) (make-mul (subst (mul-left e)  x v)
                               (subst (mul-right e) x v))]))
