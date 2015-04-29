;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-007-SimpleBoat) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 007
;    use the picture primitives to create an image of a simple boat

(define SAIL    (add-line (right-triangle 36 48 "solid" "yellow")
                           0 0 0 60 "maroon"))
(define BOW    (ellipse 20 50 "solid" "white"))
(define BOTTOM (rectangle 100 25 "solid" "white"))
(define HULL   (rectangle 100 50 "solid" "blue"))

(define BOAT (overlay/align/offset "center" "bottom" BOTTOM 0 0
   (overlay/align/offset "right" "center" BOW -10 0 
                        (overlay/align/offset "left" "center" BOW 10 0 HULL))))


(define SAILBOAT 
  (overlay/align/offset "center" "bottom" BOAT 0 -50 SAIL))
