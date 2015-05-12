;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-138-ColsAndRows) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 138. 
; Design two functions: col and row.
;
; The function col consumes a natural number n and an image i. 
; It produces a column—a vertical arrangement—of n copies of i.
;
; The function row consumes a natural number n and an image i. 
; It produces a row—a horizontal arrangement—of n copies of i
;
; Use the two functions to create a rectangle of 8 by 18 squares, each of 
; which has size 10 by 10.

; N Image -> Image
; create a column (vertical arrangement) of n images
(check-expect (col 3 (square 10 "outline" "black"))
              (above (square 10 "outline" "black")
                     (square 10 "outline" "black")
                     (square 10 "outline" "black")))

(define (col n img)
  (cond
    [(zero? n) (empty-scene 0 0)]
    [(positive? n) (above img (col (sub1 n) img))]))

; N Image -> Image
; create a row (horizontal arrangement) of n images
(check-expect (row 3 (square 10 "outline" "black"))
              (beside (square 10 "outline" "black")
                      (square 10 "outline" "black")
                      (square 10 "outline" "black")))

(define (row n img)
  (cond
    [(zero? n) (empty-scene 0 0)]
    [(positive? n) (beside img (row (sub1 n) img))]))

; N N -> Image
; create an n x n grid of 10 x 10 empty squares
(check-expect (grid 2 2)
              (above (row 2 (square 10 "outline" "black"))
                     (row 2 (square 10 "outline" "black"))))

(define (grid c r)
  (cond
    [(zero? r) (empty-scene 0 0)]
    [(positive? r)
     (above (row c (square 10 "outline" "black"))
            (grid c (sub1 r) ))]))

(grid 8 18)


