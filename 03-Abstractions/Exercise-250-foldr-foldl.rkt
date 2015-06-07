;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-250-foldr-foldl) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 250
;
; Re-write Exercise 237 using lambdas vs local functions

; [List-of Number] [List-of Number] -> [List-of Number]
; appends list b to list a
(check-expect (append-from-fold (list 1 2 3) (list 4 5 6))
              (list 1 2 3 4 5 6))
(check-expect (append-from-fold.v2 (list 1 2 3) (list 4 5 6))
              (list 6 5 4 1 2 3))

(define (append-from-fold a b)
  (foldr cons b a))                  ; no need for lambda

(define (append-from-fold.v2 a b)
  (foldl cons a b))                  ; no need for lambda

; [List-of Number] -> Number
; computes the sum of a list of numbers
(check-expect (sum '()) 0)
(check-expect (sum (list 1 2 3)) 6)

(define (sum lon)
  (foldr + 0 lon))       ; no need for lambda

; [List-of Number] -> Number
; compues the product of a list of numbers
(check-expect (product '()) 0)
(check-expect (product (list 1 2 3)) 6)

(define (product lon)
  (if (empty? lon)
      0
      (foldr * 1 lon)))  ; no need for lambda

; [List-of Image] -> Image
; composes the given images in a horizontal layout
; NOTE: if foldl is used, the order is reversed
(check-expect (layout-horiz (list (circle 30 "solid" "red")
                                  (circle 30 "solid" "yellow")
                                  (circle 30 "solid" "green")))
              (beside (circle 30 "solid" "red")
                      (circle 30 "solid" "yellow")
                      (circle 30 "solid" "green")))

(define (layout-horiz loi)
  (foldr beside empty-image loi))  ; no need for lambda

; [List-of Image] -> Image
; compose the given images in a vertical layout
(check-expect (layout-vert (list (circle 30 "solid" "red")
                                 (circle 30 "solid" "yellow")
                                 (circle 30 "solid" "green")))
              (above  (circle 30 "solid" "red")
                      (circle 30 "solid" "yellow")
                      (circle 30 "solid" "green")))

(define (layout-vert loi)
  (foldr above empty-image loi))  ; no need for lambda
