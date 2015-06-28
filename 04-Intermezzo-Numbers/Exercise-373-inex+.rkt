;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-373-inex+) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 373.
;
; Design inex+. The function adds two Inex representations of numbers that
; have the same exponent. The function must be able to deal with inputs that
; increase the exponent. Furthermore, it must signal its own error if the
; result is out of range, not rely on create-inex for error checking.

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
; add two Inex numbers; assumes exponents are the same
(check-expect (inex+ (create-inex  1 1 0) (create-inex  2 1 0))
              (create-inex 3 1 0))
(check-expect (inex+ (create-inex 55 1 0) (create-inex 55 1 0))
              (create-inex 11 1 1))
(check-expect (inex+ (create-inex 56 1 0) (create-inex 56 1 0))
              (create-inex 11 1 1))

(define (inex+.v1 x y)
  (local ((define xm (inex-mantissa x))
          (define ym (inex-mantissa y))
          (define sgn (inex-sign x))
          (define exp (inex-exponent x))
          (define rm (+ xm ym)))
    (if (> rm MAX)
          (create-inex (round (/ rm 10)) sgn (+ exp 1))
          (create-inex rm sgn exp))))
                       
; Challenge Extend inex+ so that it can deal with inputs whose exponents
; differ by 1 (see below). Do not attempt to deal with larger classes of
; inputs than that without reading the following subsection.

(check-expect (inex+ (create-inex 1 1 0) (create-inex 1 -1 1))
              (create-inex 11 -1 1))
(check-expect (inex+ (create-inex 1 -1 1) (create-inex 1 1 0 ))
              (create-inex 11 -1 1))

(define (inex+ x y)
  (local ((define xm (inex-mantissa x))
          (define ym (inex-mantissa y))
          (define xe (* (inex-sign x) (inex-exponent x)))
          (define ye (* (inex-sign y) (inex-exponent y)))
          (define sgn (inex-sign x))
          (define exp (inex-exponent x))
          (define rm (+ xm ym)))
    
  (cond [(> ye xe) (inex+ x (reduce-exp y))]
        [(> xe ye) (inex+ (reduce-exp x) y)]
        [ else (if (> rm MAX)
                   (increase-exp rm sgn exp)
                   (create-inex  rm sgn exp))])))

; N N N -> Inex
; increases the exponent by one and adjusts the mantissa
; accordingly
(check-expect (increase-exp 110 1  0) (create-inex 11 1 1))
(check-error  (increase-exp 110 1 99))

(define (increase-exp m s e)
  (cond [(> (+ e 1) 99) (error "exponent out of range")]
        [else (create-inex (round (/ m 10)) s (+ 1 e))]))

; Inex Inex -> Inex
; reduces the exponent of the number by one 
; and adjusts the mantissa accordingly

(check-expect (reduce-exp (create-inex 2 1 1))
              (create-inex 20 1 0))
(check-expect (reduce-exp (create-inex 1 -1 1))
              (create-inex 10 -1 0))
(check-expect (reduce-exp (create-inex 1 1 0))
              (create-inex 10 -1 1))
(check-error  (reduce-exp (create-inex 10 1 1)))
              
(define (reduce-exp n)
  (local ((define man (* 10 (inex-mantissa n)))
          (define exp (- (inex-exponent n) 1))
          (define s (if (< exp 0) -1 (inex-sign n))))
    (cond [(> man MAX) (error "invalid mantissa")]
          [else (create-inex man s (abs exp))])))

