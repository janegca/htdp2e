;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-277-depth) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 277. 
; 
; Design depth. The function consumes an S-expression and determines its 
; depth. An atom has a depth of 1. The depth of a list of S-expressions is 
; the maximum depth of its items plus 1.

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

; S-expr -> Number
; the depth of an S-expr
(check-expect (depth '()) 0)
(check-expect (depth '(hello 20.12 "world")) 3)
(check-expect (depth '((hello 20.12 "world"))) 3)
(check-expect (depth '((hello 20.12 "world")
                       tomorrow
                       (goodbye 2110 "earth"))) 7)

(define (depth sexp)
  (local ((define (depth-sl s) 
            (cond [(empty? s) 0]
                  [else (+ (depth    (first s))
                           (depth-sl (rest s)))])))
    (cond [(atom?  sexp) 1]
          [else (depth-sl sexp)])))

