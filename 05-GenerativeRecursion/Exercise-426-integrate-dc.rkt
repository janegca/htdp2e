;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-426-integrate-dc) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 426.
;
; Develop the algorithm integrate-dc, which integrates a function f between
; the boundaries a and b using a divide-and-conquer strategy. Use Kepler’s
; method when the interval is sufficiently small.
;
; NOTE: This is not the correct answer ... need to revisit

; -- function examples
(define EPSILON 0.1)

(define (constant x) 20)
(define (linear x) (* 2 x))
(define (square x) (* 3 (sqr x)))

; [Number -> Number] Number Number -> Number
; compute the area of the graph under f(a) and f(b)
(check-within (integrate-dc constant 12 22) 200 EPSILON)
(check-within (integrate-dc linear 0 10) 100 EPSILON)
(check-within (integrate-dc square 0 10)
              (- (expt 10 3) (expt 0 3)) EPSILON)

(define (integrate-dc.v1 f a b)
  (local ((define W (- b a))         ; rectangle width
          (define S (+ a (/ W 2)))   ; rectangle midpoint
          (define area (* W (f S)))  ; area using height at midpoint
          (define kepler (/ (* W (+ (f a) (f b))) 2)))
    (cond [(<= W 1) kepler]
          [else (+ area
                   (integrate-dc f a S)
                   (integrate-dc f S b))])))

(define (integrate-dc f a b)
  (local ((define (area c d)
            (local ((define w (- d c))
                    (define h (f (+ c (/ w 2)))))
              (* w h)))
          (define W (- b a))
          (define M (+ a (/ W 2)))
          (define kepler (/ (* W (+ (f a) (f b))) 2)))
    (cond [(<= W 10) kepler]
          [else (+ (area a M) (integrate-dc f a M)
                   (area M b) (integrate-dc f M b))])))


          
            