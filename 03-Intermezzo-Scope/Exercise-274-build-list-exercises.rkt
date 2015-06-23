;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-274-build-list-exercises) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 274. Use loops to define a function that
;
; 1. creates the list 0 ... (n - 1) for any natural number n;
; 2. creates the list 1 ... n for any natural number n;
; 3. creates the list (list 1 1/10 1/100 ...) of n numbers for any natural
;    number n;
; 4. creates the list of the first n even numbers;
; 5. creates a list of lists of 0 and 1 in a diagonal arrangement, e.g.,
;
;        (equal? (diagonal 3)
;                (list
;                  (list 1 0 0)
;                  (list 0 1 0)
;                  (list 0 0 1)));
;
; Finally, use loops to define tabulate from exercise 220.
; See exercise 235.

(require 2htdp/abstraction)

; Number -> [List-of Number]
; build a list of whole numbers from 0 to n
(check-expect (whole-nums 0) (list 0))
(check-expect (whole-nums 3) (list 0 1 2 3))

(define (whole-nums n)
  (for/list ([item (in-range 0 (+ n 1) 1)]) item))

; Number -> [List-of Number]
; build a list of counting numbers from 1 to n
(check-expect (counting-nums 0) '())
(check-expect (counting-nums 3) (list 1 2 3))

(define (counting-nums n)
  (for/list ([item (in-range 1 (+ n 1) 1)]) item))

; Number -> [List-of Number]
; compute the series n n/10 n/100 ... for any n
(check-expect (reciprocals-of-powers-of-ten 0) '())
(check-expect (reciprocals-of-powers-of-ten 1) (list 1))
(check-expect (reciprocals-of-powers-of-ten 2) (list 1 1/10))
(check-expect (reciprocals-of-powers-of-ten 3) (list 1 1/10 1/100))
(check-expect (reciprocals-of-powers-of-ten 4) (list 1 1/10 1/100 1/1000))

(define (reciprocals-of-powers-of-ten num)
  (for/list ([item (whole-nums (- num 1))]) (/ 1 (expt 10 item))))

; Number -> [List-of Number]
; return the first n even numbers
(check-expect (even-nums 4) (list 0 2 4 6))

(define (even-nums n)
  (for/list ([item (in-range 0 (* 2 n) 2)]) item))

; Number -> [List-of [List-of Number]]
; creates a list of lists of 0 and 1 a diagonal arrangement
;
; IMPLEMENTATION NOTE:
;     using for*/list here would produce a list versus a list of lists
(check-expect (diagonal 3)
              (list (list 1 0 0) (list 0 1 0) (list 0 0 1)))

(define (diagonal n)
  (local ((define nums (in-range 0 n 1)))
  (for/list ([i nums])
    (for/list ([j nums])
      (if (= i j) 1 0)))))

; Number [Number Number -> Number] -> [List-of Number]
(check-expect (tabulate 2 sqr) (list 4 1 0))
(check-within (tabulate 2 tan)
              (list (tan 2) (tan 1) (tan 0))
              0.1)
(check-within (tabulate 1 sin)
              (list (sin 1) (sin 0)) 0.1)
(check-within (tabulate 4 cos)
              (list (cos 4) (cos 3) (cos 2) (cos 1) (cos 0)) 0.1)

(define (tabulate n f)
  (reverse (for/list ([item (in-range 0 (+ n 1) 1)]) (f item))))
