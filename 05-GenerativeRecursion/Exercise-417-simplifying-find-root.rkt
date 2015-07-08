;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-417-simplifying-find-root) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 417.
;
; A function f is monotonically increasing if (<= (f a) (f b)) holds whenever
; (< a b) yields #true. Simplify find-root assuming the given function is not
; only continuous but also monotonically increasing.

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

; [Number -> Number] Number Number -> Number
; determines R such that f has a root in [R,(+ R TOLERANCE)]
; assume f is continuous 
; assume (or (<= (f left) 0 (f right)) (<= (f right) 0 (f left)))
; generative divide interval in half, the root is in one of the two
(check-satisfied (find-root poly 3 6) in-range?)

; halves, pick according to assumption that if (< a b) then (<= (f a) (f b))
(define (find-root f left right)
  (cond
    [(<= (- right left) TOLERANCE) left]                       
    [else
     (local ((define mid   (/ (+ left right) 2))
             (define f@mid (f mid))
             (define f@left (f left)))
       (cond
         [(or (<= f@left 0 f@mid) (<= f@mid 0 f@left))
          (find-root f left mid)]
         [else (find-root f mid right)]))]))
