;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-313-lookup-con) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 313. 
; 
; Design lookup-con. The function consumes an AL da and a Symbol x. It 
; produces the value of x in da—if there is a matching Association; otherwise
; it signals an error.

; An AL (association list) is [List-of Association].
; An Association is (cons Symbol (cons Number '())).

; -- Example Association Lists
(define al-x  '((x 5)))
(define al-xy '((x 5) (y 3)))

; AL Symbol -> Number
; the variables value, if found
(check-expect (lookup-con al-x  'x) 5)
(check-expect (lookup-con al-xy 'y) 3)
(check-error  (lookup-con al-x  'z))

(define (lookup-con a* s)
  (cond [(empty? a*) (error "symbol not found")]
        [(eq? s (first (first a*))) (second (first a*))]
        [else (lookup-con (rest a*) s)]))

