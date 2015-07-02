;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 3101-EX-SierpinskiTriangle) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 31.1 - Fractal Example - Sierpinski Triangle
;
; Basic description
;    "...given a [equilateral] triangle , find the midpoint of each side and
;    connect them to each other. This step yields four triangles; repeat the
;    process for each of the outer of these three triangles unless these
;    triangles are too small ..."
;
;    Alternatively, we get the same basic shape "by juxtaposing two of the
;    ... triangles and then placing one copy above these two"

(require 2htdp/image)

(define SMALL 4)
 
(define small-triangle (triangle SMALL 'outline 'red))
 
; Number -> Image
; generative: creates Sierpinski triangle of size side by generating
; one of size side/2 and placing one copy above two composed copies
 
(check-expect (sierpinski SMALL) small-triangle)
(check-expect (sierpinski (* 2 SMALL))
              (above small-triangle
                     (beside small-triangle small-triangle)))
 
(define (sierpinski side)
  (cond
    [(<= side SMALL) (triangle side 'outline 'red)]
    [else (local ((define half-sized (sierpinski (/ side 2))))
            (above half-sized
                   (beside half-sized half-sized)))]))
