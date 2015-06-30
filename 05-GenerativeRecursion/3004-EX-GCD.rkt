;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 3004-EX-GCD) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 30.04 - Example - Greatest Common Divisor (GCD)


; N[>= 1] N[>= 1] -> N
; finds the greatest common divisor of n and m

(check-expect (gcd-structural 6 25) 1)
(check-expect (gcd-structural 18 24) 6)

(define (gcd-structural n m)
  (local (; N -> N
          ; determines the greatest divisor of n and m less than i
          (define (greatest-divisor-<= i)
            (cond
              [(= i 1) 1]
              [else (if (= (remainder n i) (remainder m i) 0)
                        i
                        (greatest-divisor-<= (- i 1)))])))
    (greatest-divisor-<= (min n m))))

; the above is a naive (and time consuming) definition of GCD
; using the insight that the gcd is equal to the smaller of the
; smaller and the remainder of the larger divided by the smaller
; we get the following algorithm

(define (gcd-generative n m)
  (local (; N[>= 1] N[>=1] -> N
          ; generative recursion
          ; (gcd larger smaller) = (gcd larger (remainder larger smaller)) 
          (define (clever-gcd larger smaller)
            (cond
              [(= smaller 0) larger]
              [else (clever-gcd smaller (remainder larger smaller))])))
    (clever-gcd (max m n) (min m n))))

