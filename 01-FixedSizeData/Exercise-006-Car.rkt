;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-006-Car) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 006
;    use picture primitives to create an image of a simple car

(define BODY (rectangle 200 50 "solid" "red"))
(define TIRE (circle 20 "solid" "black"))
(define TOP  (rectangle 100 50 "outline" 
                        (make-pen "red" 20 "solid" "round" "round")))

(define auto
  (overlay/align/offset  "right" "bottom"
                         TIRE 10 0
                        (overlay/align/offset 
                         "left" "bottom" TIRE -10 -15 
                         (overlay/align/offset "center" "top" TOP 0 30 BODY))))



