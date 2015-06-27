;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-371-sexpr=) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 371.
;
; Design sexp=?, a function that determines whether two S-exprs are equal.
; For convenience, we recall the data definition here though in a condensed
; form:

    ; An S-expr (S-expression) is one of: 
    ; – Atom
    ; – [List-of S-expr]
    ; 
    ; An Atom is one of: 
    ; – Number
    ; – String
    ; – Symbol 

; Whenever you use check-expect, it uses a function like sexp=? to check
; whether the two arbitrary values are equal. If not, the check fails and
; check-expect reports it as such.

; S-expr S-expr -> Boolean
; true if the given expressions are equal, otherwise, false
(check-expect (sexp=? '() '()) #true)
(check-expect (sexp=? 1 1)     #true)
(check-expect (sexp=? "a" "a") #true)
(check-expect (sexp=? 'a 'a)   #true)
(check-expect (sexp=? 1 "a")   #false)
(check-expect (sexp=? '(1 "a" 'a) '(1 'a "a")) #false)
(check-expect (sexp=? '(1 "a" a) '(1 "a" a))   #true)
(check-expect (sexp=? '(1 (make-posn 5 5) a)
                      '(1 (make-posn 5 5) a))  #false)
(check-expect (sexp=? '(1 a) 'a) #false)
(check-expect (sexp=? 'a '(1 a)) #false)

(define (sexp=? a b)
  (local ((define (equal-atoms? v1 v2)
            (cond [(or (number? v1)
                       (symbol? v1)) (eq? v1 v2)]
                  [(string? v1)      (equal? v1 v2)]
                  [else #false])))
    
  (cond [(and (empty? a) (empty? b)) #true]
        [(and (cons? a)  (cons? b))
         (if (equal-atoms? (first a) (first b))
             (sexp=? (rest a) (rest b))
             #false)]
        [else (equal-atoms? a b)])))

