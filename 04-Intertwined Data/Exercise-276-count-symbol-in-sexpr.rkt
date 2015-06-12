;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-276-count-symbol-in-sexpr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 276. 
;
; In a sense, we designed one program that consists of three connected 
; functions. To express this fact, we can use local to organize the
; definitions (see below).

; Notice that we also renamed the first function to indicate that its primary
; argument is an S-expr.
;
; Copy the above definition into DrRacket and validate with the test suite for 
; count that it works properly.
;
; The second argument to the local functions, sy, never changes. It is always
; the same as the original symbol. Hence you can eliminate it from the local 
; function definitions and function applications. Do so and re-test the revised
; definition. In Simplifying Functions, we show you how to simplify these 
; kinds of definitions even more—which is easy to do when you have designed
; functions systematically.

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


; S-expr Symbol -> N 
; counts all occurrences of sy in sexp 
(check-expect (count 'world 'hello) 0)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)

(define (count sexp sy)
  (local (; S-expr Symbol -> N 
          ; the main function 
          (define (count-sexp sexp)
            (cond
              [(atom? sexp) (count-atom sexp)]
              [else (count-sl sexp)]))
          
          ; SL Symbol -> N 
          ; counts all occurrences of sy in sl 
          (define (count-sl sl)
            (cond
              [(empty? sl) 0]
              [else (+ (count-sexp (first sl))
                       (count-sl   (rest sl)))]))
          
          ; Atom Symbol -> N 
          ; counts all occurrences of sy in at 
          (define (count-atom at)
            ; NOTE: removed redundant conditional tests
            (if (symbol=? at sy) 1 0)))
    ; — IN 
    (count-sexp sexp)))

