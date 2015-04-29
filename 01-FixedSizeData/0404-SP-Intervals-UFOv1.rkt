;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0404-SP-Intervals-UFOv1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 04.04 Sample Problem - Intervals - UFO Landing
; Design a program that simulates the descent of a UFO.
; 
; Requested Modification:
; Add a status line that says "descending" when the UFO’s height is above one 
; third of the height of the canvas. It switches to "closing in" below that. 
; And finally, when the UFO has reached the bottom of the canvas, the status
; notifies the player that the UFO has "landed."
;
; Modified: main to call new 'render/status' function

; WorldState is a Number 
; interpretation: height of UFO (from top)

; constants: 
(define WIDTH  300)
(define HEIGHT 100)
(define CLOSE  (/ HEIGHT 3))

; visual constants: 
(define MT   (empty-scene WIDTH HEIGHT))
(define UFO  (overlay (circle 10 "solid" "green")          
                      (rectangle 40 2 "solid" "green")))

; WorldState -> WorldState
(define (main y0)  
  (big-bang y0           
            [on-tick nxt]            
            [to-draw render/status]))  ; MODIFIED

; WorldState -> WorldState
; computes next location of UFO  
(check-expect (nxt 11) 14)

(define (nxt y)  (+ y 3))

; WorldState -> Image
; place UFO at given height into the center of MT 
(check-expect  (render 11) (place-image UFO (/ WIDTH 2) 11 MT)) 

(define (render y)  (place-image UFO (/ WIDTH 2) y MT))

; WorldState -> Image
; adds a status line to the scene created by render   
(check-expect (render/status 10)              
              (place-image (text "descending" 11 "green")            
                           10 10                           
                           (render 10)))

(define (render/status y)  
  (cond    [(<= 0 y CLOSE)     
            (place-image (text "descending" 11 "green")                  
                         10 10                 
                         (render y))]    
           [(and (< CLOSE y) (<= y HEIGHT))    
            (place-image (text "closing in" 11 "orange")
                         10 10
                         (render y))]
           [(> y HEIGHT)
            (place-image (text "landed" 11 "red")
                         10 10                  
                         (render y))]))


