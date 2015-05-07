;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-090-SpaceInvaderRev2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 90
;
; Design the functions si-move.v2, si-game-over.v2?, and si-control.v2 to 
; complete the game for this second data definition. 

(define-struct tank [loc vel])
; A Tank is (make-tank Number Number). 
; interpretation: (make-tank x dx) means the tank is at position
; (x, Y-TANK) and that it moves dx pixels per clock tick  

(define-struct sigs [ufo tank missile])
; SIGS.v2 (short for version 2) 
; is (make-sigs UFO Tank MissileOrNot)
; interpretation represents the state of the space invader game  

; A UFO is Posn. 
; interpretation: (make-posn x y) is the UFO's current location  

; A MissileOrNot is one of: 
; – #false
; – Posn
; interpretation #false means the missile hasn't been fired yet
; Posn says the missile has been fired and is at the specified location. 

; Graphic Constants
(define TREE
  (underlay/xy (circle 10 "solid" "darkgreen")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define UFO  (overlay (circle 10 "solid" "green")          
                      (rectangle 40 2 "solid" "green")))

(define TANK (overlay/align "center" "bottom"
                            (rectangle 10 17 "solid" "DarkKhaki")
                            (rectangle 40 10 "solid" "DarkKhaki")))

(define MISSILE (triangle 5 "solid" "red"))

; Physical Constants
(define WIDTH        200)
(define HEIGHT       200)
(define Y-TREE       (- HEIGHT (/ (image-height TREE) 2)))
(define Y-TANK       (- HEIGHT (/ (image-height TANK) 2)))
(define TANK-HEIGHT  (+ 5 (image-height TANK)))
(define UFO-DIA      10)
(define X-TANK-DISPL (/ (image-width TANK) 2))
(define Y-UFO-DISPL  (/ (image-height UFO) 2))
(define DELTA-X      3)
(define VEL-UFO      1)
(define VEL-MISSILE  (* 2 VEL-UFO))

(define BACKGROUND
  (place-images (list TREE TREE TREE TREE TREE)
                (list(make-posn 10 Y-TREE)
                     (make-posn 20 Y-TREE)
                     (make-posn 25 Y-TREE)
                     (make-posn 180 Y-TREE)
                     (make-posn 190 Y-TREE))
                (empty-scene WIDTH HEIGHT "aliceblue")))
; -----------------------------------------------------------------------------
; Revised functions

; MissileOrNot Image -> Image 
; adds the missile image to sc for m
(check-expect (missile-render.v2 false BACKGROUND)
              BACKGROUND)
(check-expect (missile-render.v2 (make-posn 32 (- HEIGHT TANK-HEIGHT 10))
                                 BACKGROUND)
              (place-image MISSILE 32 (- HEIGHT TANK-HEIGHT 10) BACKGROUND))

(define (missile-render.v2 m scene) 
  (cond
    [(posn? m)    (place-image MISSILE (posn-x m) (posn-y m) scene)]
    [(boolean? m) scene]))

; NOTE: 
;     si-move rewrite requires a rewrite of si-move-proper
;     and the check-expect for create-random-number

; SIGS -> SIGS
; move world objects based on current state and velocities
(define (si-move.v2 w)  
  (si-move-proper.v2 w (create-random-number w)))

; SIGS -> Number
; create a random number in case a UFO should perform a horizontal jump 
(check-random (abs( create-random-number 
                    (make-sigs (make-posn 20 10) 
                               (make-tank 28 -3) 
                               false)))
              (random DELTA-X))

(define (create-random-number w)
  (if (odd? (current-seconds))
      (* -1 (random DELTA-X))
      (random DELTA-X)))

; SIGS Number -> SIGS
; move world elements at the given velocity on each clock tick
; the UFO moves at a constant downward velocity with occasional
; horizontal jumps
; the tank moves at a constant speed across the canvas
; the missile moves at two times the ufo velocity
(check-expect (si-move-proper.v2
               (make-sigs (make-posn 20 190) (make-tank 30 -3) false)  2)
               (make-sigs (make-posn 22 (+ 190 VEL-UFO))
                          (make-tank 27 -3)
                           false))

(check-expect (si-move-proper.v2
               (make-sigs (make-posn 10 20) (make-tank 30 -3) false) -2)
              (make-sigs (make-posn 8 (+ 20 VEL-UFO))
                         (make-tank 27 -3)
                         false))

(check-expect (si-move-proper.v2
               (make-sigs (make-posn 20 150) 
                          (make-tank 30 -3)
                          (make-posn 20 155)) 0) 
               (make-sigs (make-posn 20 (+ VEL-UFO 150))
                          (make-tank 27 -3)
                          (make-posn (+ 20 VEL-MISSILE) (- 155 VEL-MISSILE))))

(define (si-move-proper.v2 w n) 
  (cond
    [(boolean? (sigs-missile w))
     (make-sigs (make-posn (+ (posn-x (sigs-ufo w)) n)
                           (+ (posn-y (sigs-ufo w)) VEL-UFO))
                (make-tank (+ (tank-loc (sigs-tank w)) 
                           (tank-vel (sigs-tank w)))
                           (tank-vel (sigs-tank w)))
                false)]
    [else (make-sigs (make-posn (+ (posn-x (sigs-ufo w)) n)
                                (+ (posn-y (sigs-ufo w)) VEL-UFO))
                     (make-tank (+ (tank-loc (sigs-tank w)) 
                               (tank-vel (sigs-tank w)))
                               (tank-vel (sigs-tank w)))
                     (make-posn (+ (posn-x (sigs-missile w)) VEL-MISSILE)
                                (- (posn-y (sigs-missile w)) VEL-MISSILE)))]))

; NOTE: si-game-over? requires a rewrite of the method and
;       its check-expects

; SIGS -> Boolean
; returns true if the ufo has landed or been hit
(check-expect (si-game-over.v2? (make-sigs (make-posn 20 190) 
                                           (make-tank 30 -3) 
                                           false))
              true)
(check-expect (si-game-over.v2? (make-sigs (make-posn 10 20)
                                           (make-tank 30 -3)
                                           false))
              false)
(check-expect (si-game-over.v2? (make-sigs (make-posn 20 150) 
                                           (make-tank 30 -3)
                                           (make-posn 20 155))) true)
(check-expect (si-game-over.v2? (make-sigs (make-posn 20 100)
                                           (make-tank 30 -3)
                                           (make-posn 50 50))) false)

(define (si-game-over.v2? s) 
  (cond [(ufo-landed?   (sigs-ufo s)) true]
        [(not (boolean? (sigs-missile s))) 
         (ufo-hit? (sigs-ufo s) (sigs-missile s))]
        [else false]))

; POSN -> Boolean
; returns true if the ufo is within landing range
(check-expect (ufo-landed? (make-posn 50 190)) true)
(check-expect (ufo-landed? (make-posn 50 50)) false)

(define (ufo-landed? s)
  (>= (posn-y s) (- HEIGHT Y-UFO-DISPL)))

; Posn -> Posn -> Boolean
; returns true if the missile is within range of the UFO body
; (uses Cartesian Distance formula to determine the distance 
;  between the ufo and misiile)
(check-expect (ufo-hit? (make-posn 20 10) (make-posn 25 10)) true)
(check-expect (ufo-hit? (make-posn 50 50) (make-posn 30 90)) false)
(check-expect (ufo-hit? (make-posn 20 10) (make-posn 50 15)) false)
(check-expect (ufo-hit? (make-posn 50 50) (make-posn 50 50)) true)

(define (ufo-hit? u m)
   (<= (sqrt (+ (sqr (- (posn-x m) (posn-x u))) 
                (sqr (- (posn-y m) (posn-y u)))))
       UFO-DIA))

; NOTE:
;     required rewrite of all check-expects

; SIGS KeyEvent -> SIGS
; changes the direction of the tank on left or right arrow key event
; launches a missile (if one not already fired) on a spacebar event
(check-expect (si-control.v2 (make-sigs (make-posn 20 10)
                                        (make-tank 50 3) false) 
                          "left")
              (make-sigs (make-posn 20 10) (make-tank 50 -3) false))
(check-expect (si-control.v2 (make-sigs (make-posn 20 10) 
                                        (make-tank 50 -3) false)
                          "right")
              (make-sigs (make-posn 20 10) (make-tank 50 3) false))
(check-expect (si-control.v2 (make-sigs (make-posn 20 10)
                                        (make-tank 50 3)
                                        (make-posn 50 50))
                          "left")
              (make-sigs (make-posn 20 10)
                         (make-tank 50 -3)
                         (make-posn 50 50)))
(check-expect (si-control.v2 (make-sigs (make-posn 20 10) 
                                        (make-tank 50 3) false)
                          " ")
              (make-sigs (make-posn 20 10)
                         (make-tank 50 3)
                         (make-posn 50 (- HEIGHT TANK-HEIGHT))))

(define (si-control.v2 w ke)
  (cond
    [(or (string=? "right" ke) (string=? "left" ke))
       (make-sigs (sigs-ufo w)
                  (make-tank (tank-loc (sigs-tank w))
                                    (* -1 (tank-vel (sigs-tank w))))
                  (sigs-missile w))]
    [(and (string=? " " ke) (boolean? (sigs-missile w)))
     (make-sigs (sigs-ufo  w)
                (sigs-tank w)
                (make-posn (tank-loc (sigs-tank w))
                           (- HEIGHT TANK-HEIGHT)))]
    [else w]))

