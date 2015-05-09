;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-100-CheckedMakeVec) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 100. 
; 
; Take a look at these structure type definitions and their data definitions:

    (define-struct vec [x y])

    ; A vec is
    ; (make-vec PositiveNumber PositiveNumber)
    ; interpretation represents a velocity vector

; Develop the function checked-make-vec, which is to be understood as a
; checked version of the primitive operation make-vec. It ensures that the
; arguments to make-vec are positive numbers, and not just arbitrary numbers. 
; In other words, checked-make-vec enforces our informal data definition. 

(check-expect (checked-make-vec 3 3) (make-vec 3 3))
(check-error  (checked-make-vec "a" 1)
              "make-vec: x and y must be positive numbers")
(check-error (checked-make-vec -1 3)
             "make-vec: x and y must be positive numbers")

(define (checked-make-vec x y)  
  (cond
    [(and (number? x) (>= x 0)
          (number? y) (>= y 0)) (make-vec x y)]
    [else (error "make-vec: x and y must be positive numbers")]))

