;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-279-S-exprDefnRevisited) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 279.
; 
; Reformulate the data definition for S-expr so that the first clause is 
; expanded into the three clauses of Atom and the second clause uses the
; List-of abstraction.
;
; Re-design the count function for this data definition. Note This kind of 
; simplification is not always possible though experienced programmers tend 
; to recognize and use such opportunities.

; An S-expr (S-expression) is one of: 
; – String
; - Number
; - Symbol
; – [List-of S-expr]

; NOTE: this solution allows values of any type to be matched
;       doesn't limit the S-expr to the 3 given types

; S-expr Symbol -> N 
; counts all occurrences of sy in sexp 
(check-expect (count 'world 'hello) 0)
(check-expect (count 'world 'world) 1)
(check-expect (count '(world hello) 'hello) 1)
(check-expect (count '(((world) hello) hello) 'hello) 2)

(define (count sexp sy)
  (local ((define (count-sl s)
            (cond [(empty? s) 0]
                  [(cons? (first s))
                   (+ (count-sl (first s)) 
                      (count-sl (rest  s)))]
                  [(equal? (first s) sy)
                   (+ 1 (count-sl (rest s)))]
                  [else (count-sl (rest s))])))

    (cond [(list? sexp) (count-sl sexp)]
          [else (if (equal? sexp sy) 1 0)])))
