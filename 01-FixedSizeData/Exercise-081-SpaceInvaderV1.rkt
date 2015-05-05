;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-081-SpaceInvaderV1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 81 - Space Invaders Game
;
; Draw some sketches of what the game scenery looks like at various stages.
; Use the sketches to determine the constant and the variable pieces of the 
; game. For the former, develop physical constants that describe the dimensions
; of the world (canvas), its objects, and the graphical constants used to 
; render these objects. Then develop graphical constants for the tank, the UFO,
; the missile, and some background scenery. Finally, create your initial scene
; from the constants for the tank, the UFO, and the background.

; Graphic Constants
(define TREE
  (underlay/xy (circle 10 "solid" "darkgreen")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define UFO  (overlay (circle 10 "solid" "green")          
                      (rectangle 40 2 "solid" "green")))

(define TANK (overlay/align "center" "bottom"
                            (rectangle 10 17 "solid" "brown")
                            (rectangle 40 10 "solid" "brown")))
(define MISSILE (triangle 5 "solid" "red"))

; Physical Constants
(define WIDTH  400)
(define HEIGHT 200)
(define Y-TREE (- HEIGHT (/ (image-height TREE) 2)))
(define Y-TANK (- HEIGHT (image-height TANK)))

(define BG (empty-scene WIDTH HEIGHT "aliceblue"))
(define CANVAS
  (place-images (list TREE TREE TREE TREE TREE)
                (list(make-posn 10 Y-TREE)
                     (make-posn 15 Y-TREE)
                     (make-posn 20 Y-TREE)
                     (make-posn 310 Y-TREE)
                     (make-posn 320 Y-TREE))
                BG))

(define INITIAL-SCENE
  (overlay/align "center" "center" UFO
                 (overlay/align "left" "bottom" TANK CANVAS)))

INITIAL-SCENE