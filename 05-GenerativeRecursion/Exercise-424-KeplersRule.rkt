;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-424-KeplersRule) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 424.
;
; Kepler suggested a simple integration method. To compute a rough estimate of
; the area under f between a and b, proceed as follows:
;
; 1. divide the interval into half at mid = (a + b) / 2;
; 2. compute the areas of the two trapezoids, each determined by four points:
;
;        [(a,0),(a,f(a)),(mid,0),(mid,f(mid))]
;        [(mid,0),(mid,f(mid)),(b,0),(b,f(b))]
;
; 3.  then add the two areas.
;
; The method is known as Kepler’s rule.
;
; Design the function integrate-kepler. That is, turn the mathematical
; knowledge into a ISL+ function. Make sure to adapt the test cases from
; figure 111 to this use. Which of the three tests fails and by how much?
;
; Domain knowledge Let us take a close look at the kind of trapezoids whose
; area you need to compute. Here are the two basic shapes, without a coordinate
; system to reduce clutter:
;
; (f L)                   - a similar shape with (f L) < (f R)
; |.                       
; |   .
; |       .               - area of both shapes can be calculated using         
; -------------(f R)        a single formula:
; |           |                  
; |           |             [(R-L) * f(R)] + [1/2 * (R-L) * ((f(L) - f(R))]
; |           |
; -------------           - which is equivalent to the formula:
; L           R                   [(R-L) * (f(L) + f(R))] / 2
;
;

; -- function examples
(define EPSILON 0.1)

(define (constant x) 20)
(define (linear x) (* 2 x))
(define (square x) (* 3 (sqr x)))

; [Number -> Number] Number Number -> Number
; compute the area of the graph under f(a) and f(b) using Kepler's Rule
(check-within (integrate-kepler constant 12 22) 200 EPSILON)
(check-within (integrate-kepler linear 0 10) 100 EPSILON)
(check-within (integrate-kepler square 0 10)
              (- (expt 10 3) (expt 0 3)) EPSILON)  ; -- fails by 500

(define (integrate-kepler f a b)
  (/ (* (- b a) (+ (f a) (f b))) 2))

