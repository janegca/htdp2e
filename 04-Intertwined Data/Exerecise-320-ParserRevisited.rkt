;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exerecise-320-ParserRevisited) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 320. 
;
; Modify the parser in figure 75 so that it creates BSL-fun-expr if it is an 
; appropriate BSL expression. Also see exercise 313 [Ex 312]

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

; -- Code from Figure 75 modified to allow symbols and
;    creation of BSL-var-expr's

(define WRONG "wrong kind of S-expression")
 
(define-struct add [left right])
(define-struct mul [left right])
(define-struct fun [name arg])
 
; S-expr -> BSL-var-expr
; creates representation of a BSL-var-expression for s (if possible)

; atom errors
(check-expect (parse 10) 10)
(check-expect (parse 'h) 'h)        
(check-error  (parse "a"))          ; strings not allowed

(check-error  (parse '()))          ; length error

(check-expect (parse (list '+ 1 1)) (make-add 1 1))
(check-expect (parse (list '* 2 2)) (make-mul 2 2))
(check-error  (parse (list '() 2 1)))   ; wrong kind of s-expr
                                        ; first element not a symbol
(check-error  (parse (list '/ 2 2)))    ; wrong kind of s-expr
                                        ; no div operation

(check-expect (parse (list '+ 'x 3))  (make-add 'x 3))
(check-expect (parse (list '* 'x 'x)) (make-mul 'x 'x))

(check-expect (parse '(f (+ x 3))) (make-fun 'f (make-add 'x 3)))
(check-expect (parse '(f (+ (* x 3) 5)))
              (make-fun 'f (make-add (make-mul 'x 3) 5)))
              
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
                   [else (error WRONG)])] ; wrong kind of s-expr
                [else (error WRONG)])))   ; wrong kind of s-expr
 
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


