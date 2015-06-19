;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-308-ParseSExprToBExpr) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 313.
;
; Figure 77 presents a BSL parser for S-expressions. Specifically, the parse 
; function consumes an S-expr and produces an BSL-expr—if and only if the 
; given S-expression is the result of quoting a BSL expression that has a
; BSL-expr representative.
;
; Create test cases for the parse function until DrRacket tells you that all
; expressions in the definitions area are covered during the test run.
;
; What is unusual about the definition of this program with respect to the
; design recipe? Note One unusual aspect is that the function uses length on
; the list argument. Real parsers do not use length because it slows the 
; functions down.

; Any -> Boolean
(check-expect (atom? 10)      #true)
(check-expect (atom? "hello") #true)
(check-expect (atom? 'a)      #true)
(check-expect (atom? '())     #false)

(define (atom? v)
  (or (number? v)
      (string? v)
      (symbol? v)))

; -- Code from Figure 75

(define WRONG "wrong kind of S-expression")
 
(define-struct add [left right])
(define-struct mul [left right])
 
; S-expr -> BSL-expr
; creates representation of a BSL expression for s (if possible)

; atom errors
(check-expect (parse 10) 10)
(check-error  (parse 'h))            ; symbols not allowed
(check-error  (parse "a"))           ; strings not allowed

(check-error  (parse (list 'a 'b)))  ; length error

(check-expect (parse (list '+ 1 1)) (make-add 1 1))
(check-expect (parse (list '* 2 2)) (make-mul 2 2))
(check-error  (parse (list '() 2 1)))   ; wrong kind of s-expr
                                        ; first element not a symbol
(check-error  (parse (list '/ 2 2)))    ; wrong kind of s-expr
                                        ; no div operation

(define (parse s)
  (local (; S-expr -> BSL-expr
          (define (parse s)
            (cond
              [(atom? s) (parse-atom s)]
              [else (parse-sl s)]))
 
          ; SL -> BSL-expr 
          (define (parse-sl s)
            (local ((define L (length s)))
              (cond
                [(< L 3)
                 (error WRONG)]
                [(and (= L 3) (symbol? (first s)))
                 (cond
                   [(symbol=? (first s) '+)
                    (make-add (parse (second s)) (parse (third s)))]
                   [(symbol=? (first s) '*)
                    (make-mul (parse (second s)) (parse (third s)))]
                   [else (error WRONG)])] ; wrong kind of s-expr
                [else
                 (error WRONG)])))        ; wrong kind of s-expr
 
          ; Atom -> BSL-expr 
          (define (parse-atom s)
            (cond
              [(number? s) s]
              [(string? s) (error "strings not allowed")]
              [(symbol? s) (error "symbols not allowed")])))
    (parse s)))



