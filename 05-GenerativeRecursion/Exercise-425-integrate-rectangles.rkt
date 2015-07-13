;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-425-integrate-rectangles) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 425.
;
; Another simple integration method divides the area into many small rectangles.
; Each rectangle has a fixed width and is as tall as the function graph in the
; middle of the rectangle. Adding up the areas of the rectangles produces an
; estimate of the area under the function’s graph.
;
; Let’s use
;
;    R = 10
;
; to stand for the number of rectangles to be considered. Hence the width of
; each rectangle is:
;    W = (b - a) / R
;
; For the height of one of these rectangles, we determine the value of f at
; its midpoint. The first midpoint is clearly at a plus half of the width of
; the rectangle,
;    S = width / 2
;
; Which means its area is:
;    W * f(a + S)
;
; To compute the area of the second rectangle, we must add the width of one
; rectangle to the first midpoint:
;    W * f(a + W + S)
;
; For the third one, we get:
;    W * f(a + 2*W + S)
;
; In general, we can use the following formula for the ith rectangle:
;    W * f(a + i*W + S)
;
; The first rectangle has index 0, the last one R - 1.
;
; Using this sequence of rectangles, we can now determine the area under the
; graph as a series:
;    (W * f(a + 0*W + S)) + (W * f(a + 1*W +S)) + ... + (W * f(a + (R-1)*W + S))
;
; Design the function integrate-rectangles. That is, turn the description of
; the rectangle process an ISL+ function. Make sure to adapt the test cases
; from figure 111 to this use.
;
; The more rectangles the algorithms uses, the closer its estimate is to the
; actual area. Make R a top-level constant and increase it by factors of 10
; until the algorithm’s accuracy eliminates problems with EPSILON value of 0.1.
;
; Decrease EPSILON to 0.01 and increase R enough to eliminate any failing test
; cases again. Compare the result to exercise 424.

; -- function examples
(define EPSILON 0.01)

(define (constant x) 20)
(define (linear x) (* 2 x))
(define (square x) (* 3 (sqr x)))

; R values
;   with EPSILON 0.1
;     to pass the first two tests, only need an R of 100
;     to pass the third test, need R = 2000
;   with EPSILON 0.01
;     to pass the first two tests, only need an R of 200
;     to pass the third test, need R = 20000

(define R 20000) 

; [Number -> Number] Number Number -> Number
; compute the area of the graph under f(a) and f(b) using rectangles
(check-within (integrate-rectangles constant 12 22) 200 EPSILON)
(check-within (integrate-rectangles linear 0 10) 100 EPSILON)
(check-within (integrate-rectangles square 0 10)
              (- (expt 10 3) (expt 0 3)) EPSILON)

(define (integrate-rectangles f a b)
  (local ((define W (/ (- b a) R))  ; rectangle width
          (define S (/ W 2))        ; first midpoint
          (define (area n)
            (cond [(= n 0) 0]
                  [else (+ (* W (f (+ a (* n W) S))) (area (- n 1)))])))
    (area (- R 1))))

          