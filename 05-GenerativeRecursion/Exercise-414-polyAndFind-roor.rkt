;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-414-polyAndFind-roor) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 414.
;
; The poly function has two roots. Use find-root with poly and an interval
; that contains both roots.

(define TOLERANCE 0.5)

(define (poly x)
  (* (- x 2) (- x 4)))

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


; an interval of 1 5 would contain both roots, 2 and 4
(define ex1 (find-root poly 1 5))  ; returns 1.5


