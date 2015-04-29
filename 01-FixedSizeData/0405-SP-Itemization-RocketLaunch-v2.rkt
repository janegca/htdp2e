;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0405-SP-Itemization-RocketLaunch-v2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 04.05 Sample Problem - Itemization
;
; NOTE: this version includes the revised 'show' function from Ex 51
;       and the development of the 'fly' function
;
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
;
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
(check-expect (launch "resting" " ") -3)
(check-expect (launch "resting" "a") "resting")
(check-expect (launch -3 " ") -3)
(check-expect (launch -1 " ") -1)
(check-expect (launch 33 " ") 33)
(check-expect (launch 33 "a") 33)

(define (launch x ke)  
  (cond
    [(string? x)  (if (string=? " " ke) -3 x)]
    [(<= -3 x -1) x]
    [(>= x 0)     x]))


; LRCD -> LRCD
; raises the rocket by YDELTA,
;  if it is moving already 
(check-expect (fly "resting") "resting")
(check-expect (fly -3) -2)
(check-expect (fly -2) -1)
(check-expect (fly -1) HEIGHT)
(check-expect (fly 10) (- 10 YDELTA))
(check-expect (fly 22) (- 22 YDELTA))

(define (fly x)  
  (cond
    [(string? x) x]
    [(<= -3 x -1) (if (= x -1) HEIGHT (+ x 1))]
    [(>= x 0) (- x YDELTA)]))

; LRCD -> LRCD
(define (main1 s)
  (big-bang s
            (to-draw show)
            (on-key  launch)))

; usage example
(main1 "")