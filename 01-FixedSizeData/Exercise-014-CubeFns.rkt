;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-014-CubeFns) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 14. 
; Define the function cube-volume, which accepts the length of a side of a 
; cube and computes its volume. If you have time, consider defining
; cube-surface, too.

(define (cube-volume side) (expt side 3))
(define (cube-surface side) (* 6 (cube-volume side)))

(cube-volume 4)
(cube-surface 4)