;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-432-double-amount) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 423.
;
; Design the function double-amount, which computes how many months it takes
; to double a given amount of money when a savings account pays interest at a
; fixed rate on a monthly basis.
;
; Hint: The function must know the current amount and the initially given one;
; see ... Add Expressive Power.
;
; Domain Knowledge: With a minor algebraic manipulation, you can show that the
; given amount is irrelevant. Only the interest rate matters. Also domain
; experts know that doubling occurs after roughly 72/r as long as the interest
; rate r is not large.


; Number Number -> Number
; the number of months it takes to double the original amount (amt) at the
; given montly fixed rate of interest (r)
(check-expect (double-amount.v1 100 12) 7)     ; 72/12 ->  6
(check-expect (double-amount.v1 100  6) 12)    ; 72/6  -> 12

(define (double-amount.v1 amt r)
  (local ((define goal (* 2 amt))
          (define (calc n cv)
            (cond [(>= cv goal) n]
                  [else (calc (+ 1 n) (+ cv (* cv (/ r 100))))])))
    (calc 0 amt)))

; without using the original amount
(check-expect (double-amount 12)  7)
(check-expect (double-amount  6) 12)

(define (double-amount r)
  (local ((define (calc n cv)
            (cond [(>= cv 2) n]
                  [else (calc (+ 1 n) (+ cv (* cv (/ r 100))))])))
          (calc 0 1)))
                   