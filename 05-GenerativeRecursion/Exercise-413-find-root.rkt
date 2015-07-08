;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-413-find-root) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 413.
;
; Add the test from exercise 412 to the program in figure 103. Experiment with
; different values for TOLERANCE.

; -- code from Exercise 412
(define TOLERANCE 0.5)

; Number -> Number
; computes the root of a binomial
(check-expect (poly 2) 0)
(check-expect (poly 4) 0)

(define (poly x)
  (* (- x 2) (- x 4)))

; N[>=0] -> Boolean
; true if (poly value) is between minus plus or minus tolerance
(check-expect (in-range?  3.75) #true)
(check-expect (in-range?  1)    #false)
(check-expect (in-range? -1)    #false)

(define (in-range? value)
  (<= (abs(poly value)) TOLERANCE))

; -- code from Figure 103
;
; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R TOLERANCE)]
; assume f is continuous 
; assume (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divide interval in half, the root is in one of the two
(check-satisfied (find-root poly 3 6) in-range?)

; halves, pick according to assumption 
(define (find-root f left right)
  (cond
    [(<= (- right left) TOLERANCE) left]                       ; a
    [else
     (local ((define mid (/ (+ left right) 2))
             (define f@mid (f mid)))
       (cond
         [(or (<= (f left) 0 f@mid) (<= f@mid 0 (f left)))    ;  b
          (find-root f left mid)]
         [(or (<= f@mid 0 (f right)) (<= (f right) 0 f@mid))  ;  c
          (find-root f mid right)]))]))

; -- evaluating (find-root f 3 6) with TOLERACE = 0.5 (f = poly function)
;
;  step    left  right  mid  (f left)  (f right)  (f mid)        satisfies
;  n=1      3      6     4.5   -1          8         1.25            b
;  n=2      3      4.5   3.76  -1          1.25     -0.4375          c
;  n=3      3.75   4.5   4.125 -0.4375     1.25     10.78342929      b
;  n=4      3.75   4.125                                             a
;
;  at this point (<= (- 4.125 3.75) TOLERANCE) is #true so 3.75 is returned
