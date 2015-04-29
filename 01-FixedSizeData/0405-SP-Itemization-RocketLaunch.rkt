;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0405-SP-Itemization-RocketLaunch) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 04.05 Sample Problem - Itemization
;
; Design a program that launches a rocket when the user presses the space bar.
; At that point, the simulation starts a count-down for three ticks, before it
; displays the scenery of a rising rocket. The rocket should move upward at a 
; rate of three pixels per clock tick. 
;
; Suggests two different states

; A LR (short for: launching rocket) is one of:
; – "resting"
; - a number in [-3,-1]
; – non-negative number 
; interpretation: a rocket resting on the ground, in count-down mode, 
; or the number of pixels from the top i.e. its height 

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
    [(string? x) (place-image ROCKET 10 (- HEIGHT ROCKET-CENTER) BACKG)]
    [(<= -3 x -1) (place-image (text (number->string x) 20 "red")
                               XPOS (* 3/4 WIDTH)                  
                               (place-image ROCKET          
                                            XPOS (- HEIGHT ROCKET-CENTER) 
                                            BACKG))]    
    [(>= x 0)     (place-image ROCKET XPOS (- x ROCKET-CENTER) BACKG)]))


; LRCD KeyEvent -> LRCD
; starts the count-down when space bar is pressed, 
; if the rocket is still resting 
(define (launch x ke)  x)

; LRCD -> LRCD; raises the rocket by YDELTA,
;  if it is moving already 
(define (fly x)  x)

