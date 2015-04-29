;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0407-SP-AutomaticDoor) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 04.07 Sample Problem - Automatic Door
; 
; Design a world program that simulates the working of a door with an
; automatic door closer. If this kind of door is locked, you can unlock 
; it with a key. An unlocked door is closed but someone pushing at the
; door opens it. Once the person has passed through the door and lets go, 
; the automatic door takes over and closes the door again. When a door is 
; closed, it can be locked again.
;
; State Transitions
;         u        ''       tick        l
;  locked -> closed -> open ---> closed -> locked
;
; A DoorState is one of:
; – "locked"
; – "closed"
; – "open"

; DoorState -> DoorState
; closes an open door over the period of one tick 
(check-expect (door-closer "locked") "locked")
(check-expect (door-closer "closed") "closed")
(check-expect (door-closer "open")   "closed")

(define (door-closer state-of-door)  
  (cond    
    [(string=? "locked" state-of-door) "locked"]    
    [(string=? "closed" state-of-door) "closed"]   
    [(string=? "open"   state-of-door) "closed"]))

; DoorState KeyEvent -> DoorState
; simulates the actions on the door via three kinds of key events
;  u  - unlock
;  l  - lock
; " " - open 

(check-expect (door-actions "locked" "u") "closed")
(check-expect (door-actions "closed" "l") "locked")
(check-expect (door-actions "closed" " ") "open")
(check-expect (door-actions "open"   "a") "open")
(check-expect (door-actions "closed" "a") "closed")

(define (door-actions s k)  
  (cond    
    [(and (string=? "locked" s) (string=? "u" k)) "closed"]   
    [(and (string=? "closed" s) (string=? "l" k)) "locked"]   
    [(and (string=? "closed" s) (string=? " " k)) "open"]    
    [else s]))

; DoorState -> Image
; translates the current state of the door into a large text  
(check-expect (door-render "closed") (text "closed" 40 "red"))

(define (door-render s)  (text s 40 "red"))

; DoorState -> DoorState
; simulates a door with an automatic door closer
(define (door-simulation initial-state)  
  (big-bang initial-state          
            (on-tick door-closer)         
            (on-key door-actions)         
            (to-draw door-render)))









