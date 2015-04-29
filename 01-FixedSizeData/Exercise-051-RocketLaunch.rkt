;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-051-RocketLaunch) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 51. Take a second look at show. An expression of the shape
;
;    (place-image ROCKET 10 (- ... ROCKET-CENTER) BACKG)
;
; appears three different times in the function: twice to draw a resting 
; rocket and once to draw a flying rocket. Define an auxiliary function that 
; performs this work and thus shortens show. Why is this a good idea?

; physical constants 
(define HEIGHT 300)
(define WIDTH  100)
(define XPOS   10)
(define YDELTA 3)

; graphical constants 
(define BACKG  (empty-scene WIDTH HEIGHT))
(define ROCKET (rectangle 5 30 "solid" "red"))
(define ROCKET-CENTER (/ (image-height ROCKET) 2))

; functions
; LRCD -> Image
; renders the state as a resting or flying rocket 
(check-expect 
 (show "resting") 
 (place-image ROCKET
              XPOS (- HEIGHT ROCKET-CENTER) 
              BACKG))

(check-expect
 (show -2) 
 (place-image (text "-2" 20 "red")
              XPOS (* 3/4 WIDTH)
              (place-image ROCKET      
                           XPOS (- HEIGHT ROCKET-CENTER) 
                           BACKG)))

(check-expect 
 (show HEIGHT) 
 (place-image ROCKET XPOS (- HEIGHT ROCKET-CENTER) BACKG))

(check-expect (show 53) (place-image ROCKET XPOS (- 53 ROCKET-CENTER) BACKG))

(check-expect
 (show 0) BACKG)

(define (show x)  
  (cond    
    [(string? x)  (positionRocket HEIGHT)]
    [(<= -3 x -1) (place-image (text (number->string x) 20 "red")
                               XPOS (* 3/4 WIDTH)   
                               (positionRocket HEIGHT))]
                                
    [(>= x 0)     (positionRocket x)]))

; Number -> Image
; position the rocket at y-coord h
(define (positionRocket h)
  (place-image ROCKET XPOS (- h ROCKET-CENTER) BACKG))

; LRCD KeyEvent -> LRCD
; starts the count-down when space bar is pressed, 
; if the rocket is still resting 
(define (launch x ke)  x)

; LRCD -> LRCD; raises the rocket by YDELTA,
;  if it is moving already 
(define (fly x)  x)

