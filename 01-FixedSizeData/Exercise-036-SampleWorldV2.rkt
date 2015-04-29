;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-036-SampleWorldV2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 36. Formulate the examples as BSL tests.  

; Physical Constants (general attributes of objects in the world)
(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD (/ WIDTH-OF-WORLD 2))
(define WHEEL-RADIUS   5)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))

; Graphical Constants (images of objects in the world)
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))
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
(define (render x) BACKGROUND)

; WorldState -> WorldState
; moves the car by 3 pixels to the right every time the clock ticks

(check-expect (tock 20) 23)
(check-expect (tock 78) 81)

(define (tock ws) (+ ws 3))


; WorldState -> WorldState
; launches the program from some initial state
(define (main ws)
  (big-bang ws
            [on-tick tock]
            [to-draw render]))

