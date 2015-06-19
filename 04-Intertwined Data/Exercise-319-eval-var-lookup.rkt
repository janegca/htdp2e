;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-319-eval-var-lookup) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 319. 
;
; Design eval-var-lookup. This function has the same signature as 
; eval-variable*:

    ; BSL-var-expr AL -> Number
    ;(define (eval-var-lookup e da) ...)

; It does not use substitution, however. Instead, the function traverses the
; expression in the manner that the design recipe for BSL-var-expr suggests
; and “carries along” da. When it encounters a symbol x, the function looks
; up the value of x in da.

; A BSL-var-expr is one of: 
; – Number
; – Symbol 
; – (make-add BSL-var-expr BSL-var-expr)
; – (make-mul BSL-var-expr BSL-var-expr)

; An AL (association list) is [List-of Association].
; An Association is (cons Symbol (cons Number '())).

; -- Structures
(define-struct add [left right])
(define-struct mul [left right])

; -- Example Association Lists
(define al-x  '((x 5)))
(define al-xy '((x 5) (y 3)))

; -- Example BSL-var-expressions
(define e1 'x)
(define e2 (make-add 'x 3))
(define e3 (make-mul 1/3 (make-mul 'x 3)))
(define e4 (make-add (make-mul 'x 'x)
                     (make-mul 'y 'y)))

; -- lookup-con from Exercise 313

(define (lookup-con a* s)
  (cond [(empty? a*) (error "symbol not found")]
        [(eq? s (first (first a*))) (second (first a*))]
        [else (lookup-con (rest a*) s)]))

; BSL-var-expr AL -> Number
; the expression's value given the associated variable list, if
; the variable substitution matches and produces a numeric expression
(check-expect (eval-var-lookup 3  al-x) 3)
(check-expect (eval-var-lookup e1 al-x) 5)
(check-expect (eval-var-lookup e2 al-x) 8)
(check-expect (eval-var-lookup e3 al-x) 5)
(check-expect (eval-var-lookup e4 al-xy) 34)
(check-error  (eval-var-lookup 'z al-x))

(define (eval-var-lookup e a*)
  (cond [(number? e) e]
        [(symbol? e) (lookup-con a* e)]
        [(add?    e) 
         (+ (eval-var-lookup (add-left  e) a*) 
            (eval-var-lookup (add-right e) a*))]
        [(mul?    e)
         (* (eval-var-lookup (mul-left  e) a*) 
            (eval-var-lookup (mul-right e) a*))]))

