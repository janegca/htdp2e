;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-406-timing-gcd) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
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

; this version of gcd is naive and time consuming
(time (gcd-structural 101135853 45014640))

; Result:
;   cpu time: 8188 real time: 8296 gc time: 47
;   177