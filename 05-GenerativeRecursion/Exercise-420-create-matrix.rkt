;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-420-create-matrix) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 420.
;
; Design create-matrix. The function consumes a number n and a list of n^2
; numbers. It produces a list of n lists of n numbers, for example:
;
;    (check-expect
;      (create-matrix 2 (list 1 2 3 4))
;      (list (list 1 2)
;            (list 3 4)))
;
; Make up a second example.

; N (List-of N) -> (List-of (List-of N))
(check-expect (create-matrix 2 (list 1 2 3 4))
              (list (list 1 2)
                    (list 3 4)))
(check-expect (create-matrix 3 (list 1 2 3 4 5 6 7 8 9))
              (list (list 1 2 3)
                    (list 4 5 6)
                    (list 7 8 9)))

(define (create-matrix n nums)            
  (cond [(empty? nums) '()]
        [else (cons (take n nums) (create-matrix n (drop n nums)))]))

(define (take n nums)
  (cond [(empty? nums) '()]
        [(= 0 n) '()]
        [else (cons (first nums) (take (- n 1) (rest nums)))]))

(define (drop n nums)
  (cond [(empty? nums) '()]
        [(= 0 n) nums]
        [else (drop (- n 1) (rest nums))]))

        

