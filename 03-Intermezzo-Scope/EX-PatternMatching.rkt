;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname EX-PatternMatching) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Examples - Pattern Matching

(require 2htdp/abstraction)

; matching a literal-constant
(equal? "hello world"
        (match 4
          ['four  1]
          ["four" 2]
          [#true  3]
          [4      "hello world"]))

; matching a variable (can take on any value)
(eq? 5 (match 2
         [3 "one"]
         [x (+ x 3)]))

; matching cons
(equal? '() (match (cons 1 '())
              [(cons 1 tail)    tail]
              [(cons head tail) head]))

(equal? 2 (match (cons 2 '())
            [(cons 1 tail) tail]
            [(cons head tail) head]))

; matching a structure
(define p (make-posn 3 4))

(eq? 5 (match p
         [(posn x y) (sqrt (+ (sqr x) (sqr y)))]))

(define-struct phone [area switch four])

(eq? 11370 (match (make-phone 713 664 9993)
             [(phone x y z) (+ x y z)]))

; returns the area code only if the number is 664 9993
(eq? 713 (match (cons (make-phone 713 664 9993) '())
           [(cons (phone 713 664 9991) tail)       "no match"]
           [(cons (phone area-code 664 9993) tail) area-code]))

; match (? predicate-name)
; here 1 is not a symbol so it matches the second clause
(eq? 1 (match (cons 1 '())
         [(cons (? symbol?) tail) tail]
         [(cons head tail) head]))

; NOTES:  no specific 'default', use a variable which will match anything
;         as the final clause?


