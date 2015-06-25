;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-343-lookup-attribute) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 343. 
; 
; Design attribute-value. The function consumes a list of attributes and a 
; symbol. If the attributes list associates the symbol with a string, the
; function retrieves this string; otherwise it returns #false.—Consider
; using assq to define the function.

; An Xexpr.v2 is 
; – (cons Symbol [List-of Xexpr.v2])
; – (cons Symbol (cons [List-of Attribute] [List-of Xexpr.v2]))

; An Attribute is 
;   (cons Symbol (cons String '()))

; -- Example attribute lists
(define a0 '((initial "red")))
(define a1 '((a "amber") (b "beryl") (c "carbuncle")))

; [List-of Attribute] Symbol -> String
; the string value of the given symbol, if found, otherwise #false
(check-expect (lookup-attribute '() 'b)      #false)
(check-expect (lookup-attribute a0 'initial) "red")
(check-expect (lookup-attribute a1 'b)       "beryl")

(define (lookup-attribute.v1 a* s) 
  (local ((define res (assq s a*))) ; assq matches 1st item in a pair
    (if (cons? res)
        (second res)
        res)))
