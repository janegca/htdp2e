;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-055-TrafficLights) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 55
;
; Finish the design of a world program that simulates the traffic light FSA
; (Finite State Automata).
; The main function, traffic-light-simulation, is given along with
; the definitions for 'tl-render', 'tl-next', 'bulb', SPACE and RAD constants.
; You have to complete 'tl-render' and 'tl-next'.
;
; A TrafficLight is a String
; intepretation: a colour
;     the 'current-state' is the world-state and is the colour of
;     the light that is currently 'on' (solid colour fill)

; Physical constants
(define SPACE 5)                     ; the space between bulbs 
(define RAD (* SPACE 2))             ; a bulb's radius 

; Graphic constants
(define LIGHTS (empty-scene 100 30)) ; background

; Functions

; TrafficLight TrafficLight -> Image
; renders the light as a filled circle if the light that is 'on'
; matches the light to be rendered (c)
(define (bulb on c)  
  (if (string=? on c) (circle RAD "solid" c)
                      (circle RAD "outline" c)))

; TrafficLight -> TrafficLight
; determines the next state of the traffic light, given current-state
(check-expect (tl-next "red")    "green")
(check-expect (tl-next "yellow") "red")
(check-expect (tl-next "green")  "yellow")

(define (tl-next current-state)  
  (cond
    [(string=? current-state "red")    "green"]
    [(string=? current-state "green")  "yellow"]
    [(string=? current-state "yellow") "red"]))

; TrafficLight -> Image
; renders the current state of the traffic light as a image
(check-expect (tl-render "red")
               (place-images 
                  (list (bulb "red" "red")
                        (bulb "red" "yellow")
                        (bulb "red" "green"))
                  (list (make-posn (* 3 SPACE)  15)
                        (make-posn (* 9 SPACE)  15)
                        (make-posn (* 15 SPACE) 15))
                   LIGHTS))

(check-expect (tl-render "yellow")
               (place-images 
                  (list (bulb "yellow" "red")
                        (bulb "yellow" "yellow")
                        (bulb "yellow" "green"))
                  (list (make-posn (* 3 SPACE)  15)
                        (make-posn (* 9 SPACE)  15)
                        (make-posn (* 15 SPACE) 15))
                   LIGHTS))


(check-expect (tl-render "green")
               (place-images 
                  (list (bulb "green" "red")
                        (bulb "green" "yellow")
                        (bulb "green" "green"))
                  (list (make-posn (* 3 SPACE)  15)
                        (make-posn (* 9 SPACE)  15)
                        (make-posn (* 15 SPACE) 15))
                   LIGHTS))


(define (tl-render current-state)  
  (place-images 
   (list (bulb current-state "red")
         (bulb current-state "yellow")
         (bulb current-state "green"))
   (list (make-posn (* 3 SPACE)  15)
         (make-posn (* 9 SPACE)  15)
         (make-posn (* 15 SPACE) 15))
         LIGHTS))

; TrafficLight -> TrafficLight
; simulates a traffic light that changes with each clock tick
(define (traffic-light-simulation initial-state)  
  (big-bang initial-state           
            [to-draw tl-render]       ; draw lights
            [on-tick tl-next 1 10]))  ; reset 'on' light on each tick
                                      ; tick rate is once per second
                                      ; simulation duration is 10 seconds

; usage example
(traffic-light-simulation "red")