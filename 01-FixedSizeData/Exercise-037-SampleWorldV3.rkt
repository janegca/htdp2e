;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-037-SampleWorldV3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 37. 
; Finish the sample problem and get the program to run. That is, assuming that
; you have solved exercise 35, define the constants BACKGROUND and Y-CAR.
; Then assemble all the function definitions, including their tests. When your
; program runs to your satisfaction, add a tree to scenery (use given defintion)
; Also add a clause to the big-bang expression that stops the animation when 
; the car has disappeared on the right side of the canvas.

; Physical Constants (general attributes of objects in the world)
(define WIDTH-OF-WORLD 400)
(define WHEEL-RADIUS   5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
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

(define Y-CAR (- (image-height BACKGROUND) (* 2 WHEEL-RADIUS)))


; WorldState is a Number
; interpretation: the number of pixels between the left border and the car
; Need to develop functions:
; render
; clock-tick-handler
; key-stroke-handler
; mouse-event-handler
; end?

; WorldState -> Image
; places the image of the car x pixels from the left margin of
; the BACKGROUND image
(check-expect (render  50) (place-image CAR  50 Y-CAR BACKGROUND))
(check-expect (render 150) (place-image CAR 150 Y-CAR BACKGROUND))
(check-expect (render 250) (place-image CAR 250 Y-CAR BACKGROUND))

(define (render ws) 
  (place-image CAR ws Y-CAR BACKGROUND))


; WorldState -> WorldState
; moves the car by 3 pixels to the right every time the clock ticks

(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

(define (tock ws) (+ ws 3))

; WorldState -> Boolean
; end the program
(define (done ws) (= ws (+ WIDTH-OF-WORLD (image-width CAR))))

; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
            [on-tick   tock]
            [to-draw   render]
            [stop-when done]))

