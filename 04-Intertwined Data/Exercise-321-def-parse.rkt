;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-321-def-parse) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 321. 
; 
; Figure 76 presents a BSL definitions parser for S-expressions. Specifically,
; the def-parse function consumes an S-expr and produces a BSL-fun-def—if and 
; only if the given S-expression is the result of quoting a BSL definition 
; that has a BSL-fun-def representative.
;
; Create test cases for the def-parse function until DrRacket tells you that 
; all expressions in the definitions area are covered during the test run.
;
; Note: The exercises assumes that you have a solution for exercise 320. That
;       is, you have a function parse that turns an S-expr into a BSL-fun-expr
;       representation, if possible.
;
; With def-parse you have the essential ingredient for a parser that consumes
; an S-expression representation of a definitions area and produces a
; BSL-fun-def*. Now design the function da-parse, which parses a SL as a
; BSL-fun-def* assuming the former is a list of quoted BSL definitions.

; -- Required Structures from earlier exercises
(define-struct add [left right])
(define-struct mul [left right])
(define-struct fun [name arg])

; -- Code from Figure 76
(define WRONG "wrong kind of S-expression")
 
(define-struct def [name para body])
; see exercise 318

; -- Example function definitions
(define f1 '(define (f x) (+ 3 x)))
(define f2 '(define (g y) (f (* 2 y))))
(define f3 '(define (h v) (+ (f v) (g v))))

(define da-123 (list f1 f2 f3))
 
; S-expr -> BSL-fun-def
; creates representation of a BSL definition for s (if possible)
(check-expect (def-parse f1) (make-def 'f 'x (make-add 3 'x)))
(check-expect (def-parse f2)
              (make-def 'g 'y (make-fun 'f (make-mul 2 'y))))
(check-expect (def-parse f3)
              (make-def 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v))))

(check-error  (def-parse 's) WRONG)
(check-error  (def-parse "a") WRONG)
(check-error  (def-parse '(define f x (+ 3 x))))
(check-error  (def-parse '(define (f x y) (+ 3 x))))
(check-error  (def-parse '(define "x" (+ 3 x))))
(check-error  (def-parse '(define ("x" 3) (+ 3 x))))
(check-error  (def-parse '(define (f x) "a")))
(check-error  (def-parse '(define (f x) ('() 3 x))))
(check-error  (def-parse '(define (f x) (/ 3 x))))

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

; SL -> BSL-fun-def*
; translates a list of valid S-expressions to a list of valid
; BSL-fun-def's, if possible
(check-expect 
 (da-parse da-123)
 (list  (make-def 'f 'x (make-add 3 'x))
        (make-def 'g 'y (make-fun 'f (make-mul 2 'y)))
        (make-def 'h 'v (make-add (make-fun 'f 'v) (make-fun 'g 'v)))))


(define (da-parse sl)
  (cond [(empty? sl) '()]
        [else (append (list (def-parse (first sl)))
                       (da-parse  (rest  sl)))]))

; -- parse function from Exercise 320
; S-expr -> BLS-expr
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
