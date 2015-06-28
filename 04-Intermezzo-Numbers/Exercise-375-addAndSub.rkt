;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-375-addAndSub) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 375.
;
; As this section illustrates, gaps in the data representation lead to
; round-off errors when numbers are mapped to Inexes. The problem is, such
; round-off errors accumulate across computations.
;
; Design add, a function that adds up n copies of #i1/185. Use 0 and 1 for
; your examples; for the latter, use a tolerance of 0.0001. What is the result
; for (add 185)? What would you expect? What happens if you multiply the
; result with a large number?
;
; Design sub. The function counts how often 1/185 can be subtracted from the
; argument until it is 0. Use 0 and 1/185 for your examples. What are the
; expected results? What are the results for (sub 1) and (sub #i1.0)? What
; happens in the second case? Why?

(check-within (add 185) 1 0.0001)
(check-expect (add 0)   0)
(check-within (* (add 185) 1000000000000)
              1000000000000 0.01) ; had to increase tolerance

(define (add n)
  (cond [(eq? 0 n) 0]
        [ else ( + #i1/185 (add (- n 1)))]))

;(check-within (sub 1) 185 0.0001)       ; infinite loop
;(check-within (sub 1/185) 1 0.0001)     ; infinite loop
;(check-within (sub #i1.0) 185 0.0001)   ; infinie loop

(define (sub n)
  (cond [(eq? 0 n) n]
  [else (+ 1 (sub (- n #i1/185)))]))
