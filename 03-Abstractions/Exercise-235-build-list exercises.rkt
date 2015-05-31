;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Exercise-235-build-list exercises|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 235.
; 
; Use build-list to define functions that
;
; 1. creates the list (list 0 ... (- n 1)) for any natural number n;
;
; 2. creates the list (list 1 ... n) for any natural number n;
;
; 3. creates the list (list 1 1/10 1/100 ...) of n numbers for any natural 
;    number n;
;
; 4. creates the list of the first n even numbers;
;
; 5. creates a list of lists of 0 and 1 in a diagonal arrangement, e.g.,
;
;        (equal? (diagonal 3)
;                (list
;                  (list 1 0 0)
;                  (list 0 1 0)
;                  (list 0 0 1)))
;
; Finally, define tabulate from exercise 220 using build-list.

; Number -> [List-of Number]
; build a list of whole numbers from 0 to n
(check-expect (whole-nums 0) (list 0))
(check-expect (whole-nums 3) (list 0 1 2 3))

(define (whole-nums n)
  (cons 0 (build-list n add1)))

; Number -> [List-of Number]
; build a list of counting numbers from 1 to n
(check-expect (counting-nums 0) '())
(check-expect (counting-nums 3) (list 1 2 3))

(define (counting-nums n)
  (build-list n add1))

; Number -> [List-of Number]
; compute the series n n/10 n/100 ... for any n
(check-expect (reciprocals-of-powers-of-ten 0) '())
(check-expect (reciprocals-of-powers-of-ten 1) (list 1))
(check-expect (reciprocals-of-powers-of-ten 2) (list 1 1/10))
(check-expect (reciprocals-of-powers-of-ten 3) (list 1 1/10 1/100))
(check-expect (reciprocals-of-powers-of-ten 4) (list 1 1/10 1/100 1/1000))

(define (reciprocals-of-powers-of-ten num)
  (local (; Number -> [List-of Number]
          ; return a list from 10 to 10^n
          (define (get-recip-list n)
            (build-list n as-recip))
          
          ; Number -> Number
          ; returns the reciprocal of nth power of 10
          (define (as-recip n)
            (/ 1 (expt 10 n))))
    
    (get-recip-list num)))

; Number -> [List-of Number]
; return the first n even numbers
(check-expect (even-nums 4) (list 2 4))

(define (even-nums n)
  (filter even? (build-list n add1)))

; Number -> [List-of [List-of Number]]
; creates a list of lists of 0 and 1 a diagonal arrangement

(define (diagonal n)
  (local (; 
          (define indices (cons 0 (build-list (- n 1) add1)))
          
          (define (build-table m)
            (cond [(= m n) '()]
                  [else (cons (build-row m indices)
                              (build-table (+ m 1)))]))
          
          (define (build-row i cols)
            (cond [(empty? cols) '()]
                  [(= i (first cols))
                   (cons 1 (build-row i (rest cols)))]
                  [else (cons 0 (build-row i (rest cols)))])))
    
    (build-table 0)))




