;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-281-SimplifyingSubstituteV1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 281. 
;
; Copy and paste the above definition (for the substitute function)
; into DrRacket, including the test suite. Run and validate that the test 
; suite passes. As you read along the remainder of this section, perform the 
; edits and re-run the test suites to confirm the validity of our arguments.


; atom? from Ex 275
; Any -> Boolean
(check-expect (atom? 10)      #true)
(check-expect (atom? "hello") #true)
(check-expect (atom? 'a)      #true)
(check-expect (atom? '())     #false)

(define (atom? v)
  (or (number? v)
      (string? v)
      (symbol? v)))


; -- the original solution

; -- 1st Simplification
;    Because SL is a list we can us the higher order function
;    (abstraction) 'map'

; S-expr Symbol Atom -> S-expr
; replaces all occurrences of old in sexp with new
 
(check-expect (substitute 'world 'hello 0) 'world)
(check-expect (substitute '(world hello) 'hello 'bye) '(world bye))
(check-expect (substitute '(((world) bye) bye) 'bye '42) '(((world) 42) 42))
 
(define (substitute sexp old new)
  (local (; S-expr -> S-expr
          (define (subst-sexp sexp)
            (cond
              [(atom? sexp) (subst-atom sexp)]
              [else (subst-sl sexp)]))
 
          ; SL -> S-expr 
          (define (subst-sl sl)
            (map subst-sexp sl))
 
          ; Atom -> S-expr
          (define (subst-atom at)
            (cond
              [(number? at) at]
              [(string? at) at]
              [(symbol? at) (if (symbol=? at old) new at)])))
    ; — IN —
    (subst-sexp sexp)))

