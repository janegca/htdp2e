;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-416-revising-find-root) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 416.
;
; As presented in figure 104, find-root computes the value of f for each
; boundary value twice to generate the next interval. Use local to avoid
; this re-computation.
;
; In addition, find-root recomputes the value of a boundary across recursive
; calls. For example, (find-root f left right) computes (f left) and, if
; [left,mid] is chosen as the next interval, find-root computes (f left)
; again. Introduce a helper function that is like find-root but consumes not
; only left and right but also (f left) and (f right) at each recursive stage.
;
; How many re-computations of (f left) does this design maximally avoid?
; [ANS: roughly half]
;
; Note The two additional arguments to this helper function change at each
; recursive stage but the change is related to the change in the numeric
; arguments. These arguments are so-called accumulators, which are the topic
; of Accumulators.

(define TOLERANCE 0.5)

;Number -> Number
; computes the root of a binomial
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
; halves, pick according to assumption
(check-satisfied (find-root poly 3 6) in-range?)

(define (find-root f left right)
  (cond
    [(<= (- right left) TOLERANCE) left]
    [else
      (local ((define mid     (/ (+ left right) 2))
              (define f@mid   (f mid))
              (define f@left  (f left))
              (define f@right (f right)))
        (cond
          [(or (<= f@left 0 f@mid) (<= f@mid 0 f@left))
           (froot f left mid f@left f@right)]
          [(or (<= f@mid 0 f@right) (<= f@right 0 f@mid))
           (froot f mid right f@left f@right)]))]))

(define (froot f left right fl fr)
  (local ((define mid (/ (+ left right) 2))
          (define fm   (f mid)))
  (cond
    [(<= (- right left) TOLERANCE) left]
    [(or (<= fl 0 fm) (<= fm 0 fl))
     (find-root f left mid)]
    [(or (<= fm 0 fr) (<= fr 0 fm))
     (find-root f mid right)])))
    
     
     
     

