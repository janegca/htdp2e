;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-052-RocketLaunch) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 52. 
;
; Define main2 so that you can launch the rocket and watch it lift off.
; Read up on the on-tick clause to determine the length of one tick and
; how to change it.
;
; If you watch the entire launch, you will notice that once the rocket reaches 
; the top, something curious happens. Explain. Add a stop-when clause to main2
; so that the simulation of the lift-off stops gracefully when the rocket is 
; out of sight. 

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

(check-expect (show 0) BACKG)

(define (show x)  
  (cond    
    [(string? x)  (position-rocket HEIGHT)]
    [(<= -3 x -1) (place-image (text (number->string x) 20 "red")
                               XPOS (* 3/4 WIDTH)   
                               (position-rocket HEIGHT))]
                                
    [(>= x 0)     (position-rocket x)]))

; Number -> Image
; position the rocket at y-coord h
(define (position-rocket h)
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

; LRCD -> Boolean
; return #true when the rocket disappears at the top of the scene
(check-expect (done "")  #false)
(check-expect (done 0)   #true)
(check-expect (done 20)  #false)

(define (done ws)
  (cond
    [(string? ws) #false]
    [(= ws 0)     #true]
    [else         #false]))

; LRCD -> LRCD
(define (main2 s)
  (big-bang s
            (to-draw   show)
            (on-key    launch)
            (on-tick   fly 1/8)  ; one-eigth of a second tick interval
            (stop-when done)))

; usage example
(main2 "")
