;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-085-SpaceInvaderV2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
;Exercise 85. 
; Design the functions tank-render, ufo-render, and missile-render. 
; Is the result of this expression 
; ... (tank-render (fired-tank s)                
;                  (ufo-render (fired-ufo s)                             
;                              (missile-render (fired-missile s)
;                                              BACKGROUND))) ...
;
; the same as the result of 
; ... (ufo-render (fired-ufo s)                
;                 (tank-render (fired-tank s)                            
;                              (missile-render (fired-missile s)       
;                                               BACKGROUND))) ...
; When do the two expressions produce the same result? 
;
; [NOTES:
;     if the missile hits the ufo, it is covered by it in the
;     rendering functions (overlay, place-image or underlay all
;     result in two objects in the same location with one
;     covering the other)
;
;     the above function calls give the same results when
;     the missile is fired and when it hits; no difference
;     (see definitions and check-expects below)
;
;     IS THIS A MISTAKE IN THE RENDERING OR THE SETUP OF SI-RENDER??
;     Is there another combination that would allow the missle to 
;     show up on top of the ufo? or does it have to be done after-the
;     fact, as a seperate function call??

; Graphic Constants
(define TREE
  (underlay/xy (circle 10 "solid" "darkgreen")
               9 15
               (rectangle 2 20 "solid" "brown")))

(define UFO  (overlay (circle 10 "solid" "green")          
                      (rectangle 40 2 "solid" "green")))

(define TANK (overlay/align "center" "bottom"
                            (rectangle 10 17 "solid" "DarkKhaki")
                            (rectangle 40 10 "solid" "DarkKhaki")))
(define MISSILE (triangle 5 "solid" "red"))

; Physical Constants
(define WIDTH  200)
(define HEIGHT 200)
(define Y-TREE (- HEIGHT (/ (image-height TREE) 2)))
(define Y-TANK (- HEIGHT (/ (image-height TANK) 2)))
(define TANK-HEIGHT (+ 5 (image-height TANK)))
(define X-TANK-DISPL (/ (image-width TANK) 2))

(define BACKGROUND
  (place-images (list TREE TREE TREE TREE TREE)
                (list(make-posn 10 Y-TREE)
                     (make-posn 20 Y-TREE)
                     (make-posn 25 Y-TREE)
                     (make-posn 180 Y-TREE)
                     (make-posn 190 Y-TREE))
                (empty-scene WIDTH HEIGHT "aliceblue")))

; -----------------------------------------------------------------------
; Data Structures and Definitions

; A UFO is Posn. 
; interpretation: (make-posn x y) is the UFO's current location  

; A Missile is Posn. 
; interpretation: (make-posn x y) is the missile's current location 

(define-struct tank [loc vel])
; A Tank is (make-tank Number Number). 
; interpretation: (make-tank x dx) means the tank is at position
; (x, Y-TANK) and that it moves dx pixels per clock tick  

; A SIGS is one of: 
; – (make-aim   UFO Tank)
; – (make-fired UFO Tank Missile)
; interpretation: represents the state of the space invader game

(define-struct aim   [ufo tank])
(define-struct fired [ufo tank missile])

; -------------------------------------------------------------------
; Functions

; Tank Image -> Image 
; adds t to the given image im
(check-expect (tank-render (make-tank 0 -3) BACKGROUND)
              (place-image TANK 0 Y-TANK BACKGROUND))
(check-expect (tank-render (make-tank 28 -3) BACKGROUND)
              (place-image TANK 28 Y-TANK BACKGROUND))

(define (tank-render t im) 
  (place-image TANK (tank-loc t) Y-TANK im))

; UFO Image -> Image 
; adds u to the given image im
(check-expect (ufo-render (make-posn 10 20) BACKGROUND)
              (place-image UFO 10 20 BACKGROUND))

(define (ufo-render u im) 
  (place-image UFO (posn-x u) (posn-y u) im))

; Missile Image -> Image 
; adds m to the given image im
(check-expect (missile-render (make-posn 22 103) BACKGROUND)
              (place-image MISSILE 22 103 BACKGROUND))

(define (missile-render m im) 
  (place-image MISSILE (posn-x m) (posn-y m) im))

; SIGS -> IMAGE
; adds TANK, UFO, and possibly the MISSILE to BACKGROUND
(check-expect (si-render (make-aim (make-posn 20 10) (make-tank 28 -3))) 
              (ufo-render (make-posn 20 10) 
                          (tank-render (make-tank 28 -3) BACKGROUND)))
(check-expect (si-render (make-fired (make-posn 10 20)
                                     (make-tank 28 -3)
                                     (make-posn 32 103)))
              (ufo-render (make-posn 10 20)
                          (tank-render (make-tank 28 -3)
                                       (missile-render (make-posn 32 103)
                                                       BACKGROUND))))
(define (si-render s)  
  (cond    
    [(aim? s)     
     (tank-render (aim-tank s)                  
                  (ufo-render (aim-ufo s) BACKGROUND))]    
    [(fired? s)     
     (tank-render (fired-tank s)                 
                  (ufo-render (fired-ufo s)     
                              (missile-render (fired-missile s) 
                                               BACKGROUND)))]))

; EXAMPLES
; maneuvering tank into position
(define a1 (make-aim (make-posn 20 10) 
                     (make-tank 28 -3)))

; missile has been fired
(define f1 (make-fired (make-posn 20 10)            
                       (make-tank 28 -3)           
                       (make-posn 28 (- HEIGHT TANK-HEIGHT))))

; missile fired and close enough to ufo for a collision
(define f2 (make-fired (make-posn 20  100)            
                       (make-tank 100   3)            
                       (make-posn 22  103)))

(define ex1 (ufo-render (fired-ufo f1)               
                        (tank-render (fired-tank f1)
                                     (missile-render (fired-missile f1)
                                                     BACKGROUND))))

(define ex2 (tank-render (fired-tank f1)               
                         (ufo-render (fired-ufo f1)    
                                     (missile-render (fired-missile f1)    
                                                     BACKGROUND))))

(define ex3 (ufo-render (fired-ufo f2)               
                        (tank-render (fired-tank f2)
                                     (missile-render (fired-missile f2)
                                                     BACKGROUND))))

(define ex4 (tank-render (fired-tank f2)               
                         (ufo-render (fired-ufo f2)    
                                     (missile-render (fired-missile f2)    
                                                     BACKGROUND))))

(check-expect ex1 ex2)
(check-expect ex3 ex4)

