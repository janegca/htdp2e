;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-438-subtract) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 438.
;
; Design subtract. The function consumes two Equations of equal length.
; It subtracts the second from the first, item by item, as many times as
; necessary to obtain an Equation with a 0 in the first position. Since the
; leading coefficient is known to be 0, subtract returns the rest of the list
; that results from the subtractions.

; Equation Equation -> [List-of N]
; subtracts the second equation from the first as often as
; necessary to reduce the leading element to zero
(check-expect (subtract '(2 5 12 31) '(2 2 3 10)) '(3 9 21))
(check-expect (subtract '(4 1 -2 1)  '(2 2 3 10)) '(-3 -8 -19))

(define (subtract e1 e2)
  (local ((define (sub a b)
            (cond [(empty? a) '()]
                  [else (cons (- (first a) (first b))
                              (sub (rest a) (rest b)))]))
          (define res (sub e1 e2)))
    (cond [(= 0 (first res)) (rest res)]
          [else (subtract res e2)])))




