;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-008-SimpleTree) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 008
;   use primitives to create the image of a simple tree

(define LEAVES (star-polygon 20 11 3 "solid" "green"))
(define APPLE (circle 5 "solid" "red"))
(define TOP (place-images (list APPLE APPLE APPLE)
                          (list (make-posn 35 20) 
                                (make-posn 50 50) 
                                (make-posn 20 40)) 
                          LEAVES))
(define TRUNK  (rectangle 20 50 "solid" "brown"))

(define TREE  (overlay/align/offset "center" "top" TOP 0 60 TRUNK))
