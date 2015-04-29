;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0306-SP-DesigningAWorldProgramWithMouseEvents) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; 03.06 Adding Mouse Event handlers to Exercise 38 Sample Problem which
; moves a car across the canvas. We now to modify the code so that
; If the mouse is clicked anywhere on the canvas, the car is placed at the 
; x coordinate of that point.
;
; 1. add a function to handle a mousebutton down event
; 2. modify main to respond to mouse events
;
; (see Exercise 40 for testing new function)

; Physical Constants (general attributes of objects in the world)
(define WIDTH-OF-WORLD 400)
(define WHEEL-RADIUS     5)
(define WHEEL-DISTANCE  (* WHEEL-RADIUS 5))
(define HEIGHT-OF-WORLD (* WHEEL-RADIUS 5))

; Graphical Constants (images of objects in the world)
(define WHEEL (circle WHEEL-RADIUS "solid" "black"))
(define SPACE (rectangle  (* 4 WHEEL-RADIUS) WHEEL-RADIUS "solid" "white"))
(define BOTH-WHEELS (beside WHEEL SPACE WHEEL))

(define CAR
  (overlay/align/offset 
     "center" "top"
     (rectangle (* 4 WHEEL-RADIUS) WHEEL-RADIUS "solid" "red")
     0 WHEEL-RADIUS
     (overlay/align/offset 
        "left" "bottom" 
        BOTH-WHEELS
        (* -1 WHEEL-RADIUS) (* -1 WHEEL-RADIUS)
        (rectangle (* 10 WHEEL-RADIUS) (* 2 WHEEL-RADIUS) "solid" "red"))))

(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define BACKGROUND 
  (overlay/xy TREE
              (* -0.75 WIDTH-OF-WORLD) 10
              (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD)))

; car's y-position along the bottom edge of the background
(define Y-CAR (- (image-height BACKGROUND) (* 2 WHEEL-RADIUS)))

; equate a zero world-state with the rightmost end of the car
(define X-DISPLACEMENT (/ (image-width CAR) -2))


; WorldState is a Number
; interpretation: the number of pixels between the left border and 
; the right front end of the car

; WorldState -> Image
; places the right front end of the car x pixels from the left margin of
; the BACKGROUND image
(check-expect (render  50) 
              (place-image CAR  (+ 50 X-DISPLACEMENT) Y-CAR BACKGROUND))
(check-expect (render 150) 
              (place-image CAR (+ 150 X-DISPLACEMENT) Y-CAR BACKGROUND))
(check-expect (render 250) 
              (place-image CAR (+ 250 X-DISPLACEMENT) Y-CAR BACKGROUND))

(define (render ws) 
  (place-image CAR (+ X-DISPLACEMENT ws) Y-CAR BACKGROUND))


; WorldState -> WorldState
; moves the car by 3 pixels to the right every time the clock ticks

(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

(define (tock ws) (+ ws 3))

; WorldState -> Boolean
; return #true if the car has disappered off the right edge of the background
(define (done ws) (= ws (+ WIDTH-OF-WORLD (image-width CAR))))

; WorldState Number Number String -> WorldState
; places the car at the x coordinate if me is "button-down"
(define (hyper x-pos-of-car x-mouse y-mouse me)
  x-pos-of-car)

; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
            [on-tick   tock]
            [on-mouse  hyper]
            [to-draw   render]
            [stop-when done]))

; usage example
; (main 0)