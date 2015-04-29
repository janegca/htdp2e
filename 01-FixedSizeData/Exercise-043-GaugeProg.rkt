;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-043-GaugeProg) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 43. 
; Design a world program that maintains and displays a “happiness gauge.” 
; Let’s call it gauge-prog, and let’s agree that the program consumes the
; maximum level of happiness. The gauge display starts with the maximum score,
; and with each clock tick, happiness decreases by -0.1; it never falls 
; below 0, the minimum happiness score. Every time the down arrow key is 
; pressed, happiness increases by 1/5; every time the up arrow is pressed, 
; happiness jumps by 1/3.
;
; To show the level of happiness, we use a scene with a solid, red rectangle 
; with a black frame. For a happiness level of 0, the red bar should be gone; 
; for the maximum happiness level of 100, the bar should go all the way across 
; the scene.

; -- Physical Constants
(define GUAGE-WIDTH   100)
(define GUAGE-HEIGHT  (* 0.1 GUAGE-WIDTH))
(define DELTA         0.1)
(define BACKGROUND    (empty-scene (add1 GUAGE-WIDTH) (add1 GUAGE-HEIGHT)))

; -- Functions

; WorldState -> Image
; increases or decreases the guage level based on the value of ws
(check-expect (render 0.0) 
                (overlay/align "left" "center"
                 (rectangle 0 GUAGE-HEIGHT "solid" "red") 
                 BACKGROUND))

(check-expect (render 52.3) 
                (overlay/align "left" "center"
                 (rectangle 52.3 GUAGE-HEIGHT "solid" "red") 
                 BACKGROUND))
(check-expect (render 100.0) 
                (overlay/align "left" "center"
                 (rectangle 100.0 GUAGE-HEIGHT "solid" "red") 
                 BACKGROUND))

(define (render ws) 
  (overlay/align "left" "center"
                 (rectangle ws GUAGE-HEIGHT "solid" "red") 
                 BACKGROUND))


; WorldState -> WorldState
; decreases the guage level by DELTA for every clock tick
(check-expect (tock  20.0) 19.9)
(check-expect (tock   0.0)  0.0)
(check-expect (tock 118.8) 99.9) 

(define (tock ws) 
  (cond
    [(>= ws 100) (- 100 DELTA)] ; not part of the spec
    [(<= ws 0) 0]
    [else (- ws DELTA)]))

; WorldState -> WorldState
; ajust the guage level up 1/3 for up-arrow press, up 1/5 for down-arrow press
(check-expect (adjust  0 "up")   0.0)
(check-expect (adjust 10 "up")   (+ 10 (* 1/3 10)))
(check-expect (adjust 10 "left") 10)
(check-expect (adjust 10 "down") (+ 10 (* 1/5 10)))

(define (adjust ws ke)
  (cond
    [(key=? ke "up")   (+ ws (* 1/3 ws))]
    [(key=? ke "down") (+ ws (* 1/5 ws))]
    [else ws]))


; -- Main Program
; guage-prog is a Number between 0 and 100 representing the fill level
; of a horizontal guage
(define (guage-prog ws)
  (big-bang ws
            [on-tick   tock]
            [on-key    adjust]
            [to-draw   render]))

; usage example
(guage-prog 100)