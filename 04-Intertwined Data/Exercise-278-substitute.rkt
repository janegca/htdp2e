;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-278-substitute) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 278. 
; 
; Design the substitute function. It consumes an S-expression s and two 
; symbols, old and new. The result is like s with all occurrences of old 
; replaced by new.

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

; S-expr Atom Atom -> S-expr
(check-expect (substitute '() 'hello 'goodbye) '())
(check-expect (substitute 'hello 'hello 'goodbye) 'goodbye)
(check-expect (substitute '(hello 20.12 "world") 'hello 'goodbye)
              '(goodbye 20.12 "world"))
(check-expect (substitute '((hello 1 2) (hello 3 hello)) 'hello 'goodbye)
              '((goodbye 1 2) (goodbye 3 goodbye)))

(define (substitute sexp old new)
  (local (; SL -> SL
          ; substitues the new value for the old value where applicable
          ; within a list of S-expressions
          (define (sub-sl s)
            (cond [(empty? s) '()]
                  [(atom? (first s)) (cons (sub-atom (first s))
                                           (sub-sl   (rest  s)))]
                  [else (cons (sub-sl (first s))
                              (sub-sl (rest  s)))]))
                             
          ; Atom -> Atom
          ; replaces the old value with the new value where applicable
          (define (sub-atom s)
            (cond [(equal? s old) new]
                  [else s])))
    ; -- IN --
    (cond [(atom? sexp) (sub-atom sexp)]
          [else (sub-sl sexp)])))



