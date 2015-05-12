;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-143-FiringShotsRevised) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 143. 
;
; Experiment whether the arbitrary decisions concerning constants are 
; truly easy to change. For example, determine whether changing a single 
; constant definition achieves the desired outcome:
;
;    change the height of the canvas to 220 pixels
;    change the width of the canvas to 30 pixels
;    change the x location of the line of shots to “somewhere to the left 
;    of the middle
;    change the background to a green rectangle; and
;    change the rendering of shots to a red elongated rectangle.
;
; Also check whether it is possible to double the size of the shot without 
; changing anything else, change its color to black, or change its form to
; "outline"

; physical constants 
(define HEIGHT 220)
(define WIDTH   30)
(define XSHOTS (- (/ WIDTH 2) 10))

; graphical constants 
(define BACKGROUND (empty-scene WIDTH HEIGHT "green"))
(define SHOT (rectangle 6 12 "outline" "black"))

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
(check-expect (tock (cons 0 (cons 2 (cons 30 '()))))
              (cons -1(cons 1(cons 29 '()))))

(define (tock w) 
  (cond    [(empty? w) '()]   
           [else (cons (sub1 (first w)) (tock (rest w)))]))

; ShotWorld KeyEvent -> ShotWorld 
; adds a shot to the world if the space bar was hit 
(check-expect (keyh (cons 10 '()) " ") 
              (cons HEIGHT (cons 10 '())))

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
