;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-327-eval-allv1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
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

; -- Code from earlier exercises
(define-struct const [name value])
(define-struct def   [name param body])
(define-struct fun   [name arg])
(define-struct add   [left right])
(define-struct mul   [left right])

; -- Example definitions
(define d1 (make-const 'close-to-pi 3.14))
(define d2 (make-def   'area-of-circle 'r
                       (make-mul 'close-to-pi
                                 (make-mul 'r 'r))))
(define d3 (make-def 'volume-of-10-cylinder 'r
                     (make-mul 10 (make-fun 'area-of-circle 'r))))
(define d4 (make-def 'add2 'n
                     (make-add 2 'n)))
(define d5 (make-def 'f 'x (make-add 3 'x)))
(define d6 (make-def 'g 'y (make-fun 'f (make-mul 2 'y))))
;(define d7 (make-def 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v))))
(define d7 (make-def 'h 'v (make-add (make-add 3 'v)
                                     (make-add 3 (make-mul 2 'v)))))

(define da-all (list `(close-to-pi ,d1)
                     `(area-of-circle ,d2)
                     `(volume-of-10-cylinder ,d3)
                     `(add2 ,d4)
                     `(f ,d5)
                     `(g ,d6)
                     `(h ,d7)))

; -- Functions
; BSL-da-all Symbol -> Symbol
; the symbol value, if found, otherwise #false
(check-expect (lookup-symbol da-all 'k) #false)

(define (lookup-symbol a* s)
  (cond [(empty? a*) #false]
        [(eq? s (first (first a*))) (second (first a*))]
        [else (lookup-symbol (rest a*) s)]))

; BSL-expr BSL-da-all -> Number
; the value of the given expression, if possible
(check-expect (eval-all 'close-to-pi da-all) 3.14)
(check-within (eval-all (make-mul 3 'close-to-pi) da-all) 9.42 0.01)
(check-within (eval-all (make-fun 'area-of-circle 1) da-all) 3.14 0.01)
(check-within (eval-all (make-fun 'volume-of-10-cylinder 1) da-all)
              31.40 0.01)
(check-expect (eval-all (make-fun 'add2 10) da-all) 12)
(check-expect (eval-all (make-fun 'f 3) da-all) 6)
(check-expect (eval-all (make-fun 'g 3) da-all) 9)
(check-expect (eval-all (make-fun 'h 3) da-all) 15)

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
         (+ (eval-all (add-left  e) da)
            (eval-all (add-right e) da))]
        [(mul? e)
         (* (eval-all (mul-left  e) da)
            (eval-all (mul-right e) da))])
  )
