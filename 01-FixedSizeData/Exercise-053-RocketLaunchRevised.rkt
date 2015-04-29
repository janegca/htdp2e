;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-053-RocketLaunchRevised) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 53. 
;
; Recall that the word “height” forced us to choose one of two possible
; interpretation. Now that you have solved the exercises in this section, 
; solve them again using the first interpretation of the word. Compare and 
; contrast the solutions. 
;
; NOTES:
; Two meanings for height:
;
;   1. the word “height” could refer to the distance between the ground and
;      the rocket’s point of reference, say, its center; or
;
;   2. it could mean the distance between the top of the canvas and the 
;      reference point.
;
; The original solution used the second meaning; this exercise revises
; the code in Exercise 052 to use the first meaning of height measured
; as the rocket's position above the 'ground'

; physical constants 
(define HEIGHT 300) 
(define WIDTH  100)
(define XPOS    10)
(define YDELTA   3)   ; rocket motion at each clock-tick

; graphical constants 
(define BACKG         (empty-scene WIDTH HEIGHT))
(define ROCKET        (rectangle 5 30 "solid" "red"))
(define ROCKET-CENTER (/ (image-height ROCKET) 2))
(define GROUND        (- HEIGHT ROCKET-CENTER))

; functions
; LRCD -> Image
; renders the state as a resting or flying rocket 
(check-expect (show "resting") (place-image ROCKET XPOS GROUND BACKG))
(check-expect (show -2)
              (place-image (text "-2" 20 "red")
                            XPOS (* 3/4 WIDTH)
                           (place-image ROCKET XPOS GROUND BACKG)))
(check-expect (show 0)   (place-image ROCKET XPOS GROUND BACKG))
(check-expect (show 190) (place-image ROCKET XPOS (- GROUND 190) BACKG))
(check-expect (show HEIGHT) BACKG)

(define (show x)
  (cond
    [(string? x) (position-rocket 0)]                  ; pre-launch
    [(< x 0)                                           ; in countdown
     (place-image (text (number->string x) 20 "red")
                          XPOS (* 3/4 WIDTH)
                          (position-rocket 0))]         
    [else (position-rocket x)]))                       ; in flight

; Number -> Image
; position the rocket at h distance from the ground
(check-expect (position-rocket -3) 
              (place-image ROCKET XPOS (- GROUND -3) BACKG))
(check-expect (position-rocket 0) 
              (place-image ROCKET XPOS GROUND BACKG))
(check-expect (position-rocket HEIGHT)
              (place-image ROCKET XPOS (- GROUND HEIGHT) BACKG))

(define (position-rocket h)
  (place-image ROCKET XPOS (- GROUND h) BACKG))

; LRCD KeyEvent -> LRCD
; starts the count-down when space bar is pressed, 
; if the rocket is still resting 
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)

(define (launch x ke)  
  (cond
    [(string? x)                  ; pre-launch condition
     (if (string=? " " ke) -3 x)] ;   spacebar event detected
    [else x]))                    ; post-launch, ignore key events

; LRCD -> LRCD
; raises the rocket by YDELTA, if it is moving already 
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1)  0)
(check-expect (fly 10) (+ 10 YDELTA))
(check-expect (fly 22) (+ 22 YDELTA))

(define (fly x)  
  (cond
    [(string? x) x]              ; pre-launch
    [(< x 0)    (+ x 1)]         ; in countdown
    [(>= x 0)   (+ x YDELTA)]))  ; in flight

; LRCD -> Boolean
; returns #true if the rocket has moved past the top 
; edge of the background
(define (done ws)
  (cond
    [(string? ws)  #false]    ; pre-launch
    [(= ws HEIGHT) #true]     ; in flight, out of scene
    [else          #false]))  ; in countdown or mid-flight

; LRCD -> LRCD
; sets a rocket in motion, s is a string pre-launch, 
; a negative number during launch countdown and a
; positive number, increasing by 3 at each clock tick, 
; after the launch countdown
(define (main s)
  (big-bang s
            (to-draw   show)     ; position the rocket in the scene
            (on-key    launch)   ; space bar event starts the launch countdown
            (on-tick   fly 0.05) ; set the rocket's in-flight position at each
                                 ;   clock tick; rate is 20 times per second
            (stop-when done)))   ; finish when the rocket exits the scene

; usage example
(main "")



