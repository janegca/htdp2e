;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-328-eval-all-sexpr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 328.
;
; It is cumbersome to enter the structure-based data representation of a BSL
; expressions and a definitions area. It is much easier to quote an actual
; expression or a definitions area after surrounding it with parentheses.
;
; Design a function eval-all-sexpr. It consumes an S-expr and an Sl. The
; former is supposed to represent an expression and the latter a list of
; definitions. The function parses both with the appropriate parsing functions
; and then uses eval-all from exercise 327 to evaluate the expression.
;
; Hint: You must slightly modify da-parse from exercise 325 so that it can
;       parse constant definitions, too.
;
; You should know that eval-all-sexpr makes it straightforward to check
; whether it really mimics DrRacket’s evaluator.

; TOD0 - errors with d5

; -- Structures from earlier exercises
(define-struct const [name value])
(define-struct def   [name param body])
(define-struct fun   [name arg])
(define-struct add   [left right])
(define-struct mul   [left right])

; -- Example functions as S-expr's
(define f1 '(f 3))
(define f2 '(g 3))
(define f3 '(h 3))
 
; -- Example function definitions as S-expr's
(define d1 '(define (f x) (+ 3 x)))
(define d2 '(define (g y) (f (* 2 y))))
(define d3 '(define (h v) (+ (f v) (g v))))
(define d4 '(close-to-pi 3.14))
(define d5 '(define area-of-circle r (* close-to-pi (* r r))))

(define se-da-all (list d1 d2 d3 d4))

; -- Error messages
(define WRONG "wrong kind of S-expression")

; -- Parsers from earlier exercises

; SL -> BSL-fun-def*
; translates a list of valid S-expressions to a list of valid
; BSL-fun-def's, if possible
(check-expect 
 (da-parse se-da-all)
 (list  (make-def 'f 'x (make-add 3 'x))
        (make-def 'g 'y (make-fun 'f (make-mul 2 'y)))
        (make-def 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v)))
        (make-const 'close-to-pi 3.14)))

(define (da-parse sl)
  (cond [(empty? sl) '()]
        [else (append (list
                       (cond [(equal? 'define (first (first sl)))
                              (def-parse (first sl))]
                             [else                              
                              (make-const (first (first sl))
                                          (second (first sl)))]))
                       (da-parse  (rest  sl)))]))

; S-expr -> BSL-fun-def
; creates representation of a BSL definition for s (if possible)
(check-expect (def-parse d1) (make-def 'f 'x (make-add 3 'x)))
(check-expect (def-parse d2)
              (make-def 'g 'y (make-fun 'f (make-mul 2 'y))))
(check-expect (def-parse d3)
              (make-def 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v))))

(define (def-parse s)
  (local (; S-expr -> BSL-fun-def
          (define (def-parse s)
            (cond
              [(atom? s) (error WRONG)]
              [else
               (if (and (= (length s) 3) (eq? (first s) 'define))
                   (head-parse (second s) (parse (third s)))
                   (error WRONG))]))
          
          ; S-expr BSL-expr -> BSL-fun-def
          (define (head-parse s body)
            (cond
              [(atom? s) (error WRONG)]
              [else
               (if (not (= (length s) 2))
                   (error WRONG)
                   (local ((define name (first s))
                           (define para (second s)))
                     (if (and (symbol? name) (symbol? para))
                         (make-def name para body)
                         (error WRONG))))])))
    (def-parse s)))

; S-expr -> BSL-expr
; translates an S-expr into a BSL-expr, if possible
(define (parse s)
  (local (; SL -> BSL-expr 
          (define (parse-sl s)
            (local ((define L (length s)))
              (cond
                [(and (= L 2) (symbol? (first s)))
                 (make-fun (first s) (parse (second s)))]               
                [(and (= L 3) (symbol? (first s)))
                 (cond
                   [(symbol=? (first s) '+)
                    (make-add (parse (second s)) (parse (third s)))]
                   [(symbol=? (first s) '*)
                    (make-mul (parse (second s)) (parse (third s)))]
                   [else (error WRONG)])] 
                [else (error WRONG)])))        
 
          ; Atom -> BSL-expr 
          (define (parse-atom s)
            (cond
              [(number? s) s]
              [(string? s) (error "strings not allowed")]
              [(symbol? s) s])))
    ; -- IN --
    (cond
      [(atom? s) (parse-atom s)]
      [else (parse-sl s)])))
  
; -- atom? from Exercise 275
; Any -> Boolean
(check-expect (atom? 10)      #true)
(check-expect (atom? "hello") #true)
(check-expect (atom? 'a)      #true)
(check-expect (atom? '())     #false)

(define (atom? v)
  (or (number? v)
      (string? v)
      (symbol? v)))

; -- Evaluators from earlier exercises

; BSL-expr BSL-da-all -> Number
; the value of the given expression, if possible
(define (eval-all e da)
  (cond [(number? e) e]
        [(symbol? e) (eval-all (lookup-symbol da e) da)]
        [(const?  e) (const-value e)]
        [(fun?    e)
         (local ((define arg (fun-arg e))
                 (define fd (lookup-symbol da (fun-name e)))
                 (define b   (def-body  fd))
                 (define x   (def-param fd)))                 
           (if (symbol? arg)                          ; if arg is a symbol
               (eval-all b da)                        ; assume it's in da
               (eval-all b (cons (list x arg) da))))] ; otherwise, add value
        [(add? e)
         (+ (eval-all (add-left e)  da)
            (eval-all (add-right e) da))]
        [(mul? e)
         (* (eval-all (mul-left  e) da)
            (eval-all (mul-right e) da))])
  )

; BSL-da-all Symbol -> Symbol
; the symbol value, if found, otherwise #false

(define (lookup-symbol a* s)
  (cond [(empty? a*) #false]
        [(eq? s (first (first a*))) (second (first a*))]
        [else (lookup-symbol (rest a*) s)]))

; -- Exercise Functions

(require 2htdp/abstraction)

; S-expr SL -> Number
; if possible, the value of the expressions based on the given
; definitions
(check-expect (eval-all-sexpr f1 se-da-all)  6)
(check-expect (eval-all-sexpr f2 se-da-all)  9)
;(check-expect (eval-all-sexpr f3 se-da-all) 15)
(check-expect (eval-all-sexpr 'close-to-pi se-da-all) 3.14)

(define (eval-all-sexpr se sl)
  (local ((define bsl-da (da-parse sl))
          (define da-all (for/list ((a bsl-da) (b bsl-da))
                           (list
                            (cond [(def? a) (def-name a)]
                                  [else (const-name a)])
                            b))))
    ; -- IN --
    (eval-all (parse se) da-all)))