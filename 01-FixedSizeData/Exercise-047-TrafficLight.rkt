;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-047-TrafficLight) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 47. 
; Design an interactive program that simulates a traffic light for a given
; duration. The program renders the state of a traffic light as a solid circle
; of the appropriate color, and it changes state on every clock tick. 
; What is the most appropriate initial state? Ask your engineering friends.

; -- Physical Constants
(define RADIUS   10)
(define BG-WIDTH (* 3 RADIUS))

; -- Graphical Constants
(define BACKGROUND (empty-scene BG-WIDTH BG-WIDTH "black"))

; -- Functions
; TrafficLight -> TrafficLight
; Determines the next state of the traffic light from the given s 
(check-expect (traffic-light-next "red")    "green") 
(check-expect (traffic-light-next "green")  "yellow") ; added check
(check-expect (traffic-light-next "yellow") "red")    ; added check

(define (traffic-light-next s)  
  (cond    
    [(string=? "red"    s) "green"]   
    [(string=? "green"  s) "yellow"]    
    [(string=? "yellow" s) "red"]))

; WorldState -> Image
; redraws the traffic light using the colour given by cs
(check-expect
 (render "red")   
 (overlay/align "center" "center" (circle RADIUS "solid" "red") BACKGROUND))
(check-expect
 (render "green")   
 (overlay/align "center" "center" (circle RADIUS "solid" "green") BACKGROUND))
(check-expect
 (render "yellow")   
 (overlay/align "center" "center" (circle RADIUS "solid" "yellow") BACKGROUND))

(define (render cs)
  (overlay/align "center" "center" (circle RADIUS "solid" cs) BACKGROUND))

; WorldState -> WorldState
; changes the colour of the traffic light on every clock tick
(define (tock cs)
  (traffic-light-next cs))

; -- Main function
; TrafficLight is a String that determines the colour of the
; rendered traffic light
(define (traffic-light cs)
  (big-bang cs
            [on-tick tock]
            [to-draw render]))

; usage example
(traffic-light "red")