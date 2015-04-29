;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-046-TrafficLight) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 46. 
; If you copy and paste the above function definition into the definitions 
; area of DrRacket and click RUN, DrRacket highlights two of the three cond 
; lines. This coloring tells you that your test cases do not cover the full 
; conditional. Add enough tests to make DrRacket happy.

; A TrafficLight shows one of three colors:
; – "red"
; – "green"
; – "yellow"
; interpretation: each element of TrafficLight represents which colored
; bulb is currently turned on

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
