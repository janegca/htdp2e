;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0601-SP-SpaceInvadersGame) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 06.01 - Sample Program - Space Invaders Game
;
; Design a game program using the universe library for playing a simple space 
; invader game. The player is in control of a tank (a small rectangle) that
; must defend our planet (the bottom of the canvas) from a UFO (see Intervals
; for one possibility) that descends from the top of the canvas to the bottom. 
; In order to stop the UFO from landing, the player may fire a single missile 
; (a triangle smaller than the tank) by hitting the space bar. In response, 
; the missile emerges from the tank. If the UFO collides with the missile, the
; player wins; otherwise the UFO lands and the player loses.
;
; Here are some details concerning the three game objects and their movements.
; First, the tank moves a constant speed along the bottom of the canvas though
; the player may use the left arrow key and the right arrow key to change 
; directions. 
;
; Second, the UFO descends at a constant velocity but makes small random jumps
; to the left or right. 
;
; Third, once fired the missile ascends along a straight vertical line at a 
; constant speed at least twice as fast as the UFO descends. 
;
; Finally, the UFO and the missile collide if their reference
; points are close enough, for whatever you think “close enough” means.

; A UFO is Posn. 
; interpretation: (make-posn x y) is the UFO's current location  

(define-struct tank [loc vel])
; A Tank is (make-tank Number Number). 
; interpretation: (make-tank x dx) means the tank is at position
; (x, HEIGHT) and that it moves dx pixels per clock tick  

; A Missile is Posn. 
; interpretation (make-posn x y) is the missile's current location 

; A SIGS is one of: 
; – (make-aim   UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation: represents the state of the space invader game

(define-struct aim   [ufo tank])
(define-struct fired [ufo tank missile])

; examples
(define HEIGHT      200)
(define TANK-HEIGHT  20)

; maneuvering tank into position
(make-aim (make-posn 20 10) (make-tank 28 -3))

; missile has been fired
(make-fired (make-posn 20 10)            
            (make-tank 28 -3)           
            (make-posn 28 (- HEIGHT TANK-HEIGHT)))

; missile fired and close enough to ufo for a collision
(make-fired (make-posn 20  100)            
            (make-tank 100   3)            
            (make-posn 22  103))

