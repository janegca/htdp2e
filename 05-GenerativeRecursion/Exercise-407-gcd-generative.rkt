;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-407-gcd-generative) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 407.
;
; Copy gcd-generative into the definitions area of DrRacket and evaluate
;
;    (time (gcd-structural 101135853 45014640))
;
; in the interactions area.

(define (gcd-generative n m)
  (local (; N[>= 1] N[>=1] -> N
          ; generative recursion
          ; (gcd larger smaller) = (gcd larger (remainder larger smaller)) 
          (define (clever-gcd larger smaller)
            (cond
              [(= smaller 0) larger]
              [else (clever-gcd smaller (remainder larger smaller))])))
    (clever-gcd (max m n) (min m n))))

(time (gcd-generative 101135853 45014640))

; Result:
; cpu time: 0 real time: 0 gc time: 0
; 177

