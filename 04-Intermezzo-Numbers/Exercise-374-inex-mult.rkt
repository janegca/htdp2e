;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-374-inex-mult) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 374.
;
; Design inex*. The function multiplies two Inex representations of numbers,
; including inputs that force an additional increase of the output’s exponent.
; Like inex+, it must signal its own error if the result is out of range, not
; rely on create-inex to perform error checking.

; -- code from EX-Representing Numbers
(define-struct inex [mantissa sign exponent])

; N Number N -> Inex
; make an instance of Inex after checking the arguments
(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s 1) (= s -1)))
     (make-inex m s e)]
    [else
     (error 'inex "(<= 0 m 99), s in {+1,-1}, (<= 0 e 99) expected")]))
 
; -- code for exercise
(define MAX 99)

; Inex Inex -> Inex
; multiply to inex's
(check-expect (inex* (create-inex  2 1 4) (create-inex  8 1 10))
              (create-inex 16 1 14))
(check-expect (inex* (create-inex  20 1 1) (create-inex   5 1 4))
              (create-inex 10 1 6))
(check-expect (inex* (create-inex  27 -1 1) (create-inex   7 1 4))
              (create-inex 19 1 4))

(define (inex* x y)
  (local ((define xm (inex-mantissa x))
          (define xe (* (inex-sign x) (inex-exponent x)))
          (define ym (inex-mantissa y))
          (define ye (* (inex-sign y) (inex-exponent y)))
          (define rm (* xm ym))
          (define re (+ xe ye)))
    (cond [(> rm MAX)
           (create-inex (round (/ rm 10)) (sgn re) (+ 1 (abs re)))]
          [(> (abs re) MAX)
           (create-inex (* 10 rm) (sgn re) (- (abs re) 1))]
          [else (create-inex rm (sgn re) (abs re))])))

