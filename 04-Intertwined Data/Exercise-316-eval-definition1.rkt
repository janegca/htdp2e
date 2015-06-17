;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-316-eval-definition1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 316.
; 
; Design eval-definition1. The function is given an expression (representation)
; in the extended data definition of exercise 315 and the one function
; definition that is assumed to exist in the definitions area. It evaluates
; the given expression and returns its value.
;
; Specification, eval-definition1 consumes four arguments:
;
; 1. a BSL-fun-expr e;
; 2. a symbol f, which represents a function name;
; 3. a symbol x, which represents the functions’s parameter; and
; 4. a BSL-fun-expr b, which represents the function’s body.
;
; If the terminology poses any difficulties, do re-read BSL: Grammar.
;
; To determine the value of e, the function proceeds as before. When it
; encounters an application of f to some argument,
;
; 1. eval-definition1 evaluates the argument,
; 2. substitutes the value of the argument for x in b; and
; 3. finally evaluates the resulting expression with eval-definition1.
;
; Here is how to express the steps as code, assuming arg is the argument of 
; the function application:
;
;    (eval-definition1 (subst b x (eval-definition1 arg f x b)) f x b)
;
; Notice that this line uses a form of recursion that you have not encountered
; so far. The proper design of such functions is discussed in Generative 
; Recursion.
;
; If eval-definition1 encounters a variable, it signals the same error as 
; eval-variable from exercise 311. Also, for function applications that do 
; not refer to f, eval-definition1 signals an error as if it had encountered a variable.
;
; Warning The use of generative recursion introduces a new element into your
; computations: non-termination. That is, given some argument, a program may
; not deliver a result or signal an error but run forever. For fun, you may
; wish to construct an input for eval-definition1 that causes it to run
; forever. Use STOP to terminate the program.

; TODO
