;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 10.05-SP-FiringShots) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 10.05 - Sample Problem - Firing Shots
;
; Design a world program that simulates firing shots. Every time the “player” 
; hits the space bar, the program adds a shot to the bottom of the canvas.
; These shots rise vertically at the rate of one pixel per tick.

; physical constants 
(define HEIGHT 80)
(define WIDTH 100)
(define XSHOTS (/ WIDTH 2))

; graphical constants 
(define BACKGROUND (empty-scene WIDTH HEIGHT))
(define SHOT (triangle 3 "solid" "red"))

; -- Data Definitions

; A List-of-shots is one of:
; – '()
; – (cons Shot List-of-shots)
; interpretation the collection of shots fired and moving straight up

; A Shot is a Number. 
; interpretation the number represents the shot's y coordinate 

; A ShotWorld is List-of-numbers. 
; interpretation each number represents the y coordinate of a shot

; -- Functions

; ShotWorld -> Image
; adds each y on w at (MID,y) to the background image 
(check-expect (to-image (cons 10 '()))              
              (place-image SHOT XSHOTS 10 BACKGROUND))

(define (to-image w)  
  (cond    [(empty? w) BACKGROUND]   
           [else 
            (place-image SHOT XSHOTS (first w) (to-image (rest w)))]))


; ShotWorld -> ShotWorld
; moves each shot up by one pixel 
(define (tock w) 
  (cond    [(empty? w) '()]   
           [else (cons (sub1 (first w)) (tock (rest w)))]))

; ShotWorld KeyEvent -> ShotWorld 
; adds a shot to the world if the space bar was hit 
(define (keyh w ke) 
  (cond  
    [(key=? ke " ") (cons HEIGHT w)]  
    [else w]))


; ShotWorld -> ShotWorld 
(define (main w0)  
  (big-bang w0         
            (on-tick tock)   
            (on-key keyh)    
            (to-draw to-image)))


; usage example
(main (cons 0 '()))






