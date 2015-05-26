;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 1306-SP-SimpleFSM) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")))))
; 13.06 - Sample Problem - Simple FSM
;
; Design a program that interprets a given FSM on a specific list of
; KeyEvents. That is, the program consumes a data representation of a FSM
; and a string. Its result is #true if the string matches the regular 
; expression that corresponds to the FSM; otherwise it is #false.

; A FSM is one of:
;   – '()
;   – (cons Transition FSM)
 
(define-struct transition [current next])
; A Transition is 
;   (make-transition FSM-State FSM-State)
 
; FSM-State is a String that specifies a color. 
 
; interpretation: A FSM represents the transitions that a
; finite state machine can take from one state to another 
; in reaction to key strokes 

; An example of state transitions
(define fsm-traffic
  (list (make-transition "red"    "green")
        (make-transition "green"  "yellow")
        (make-transition "yellow" "red")))


(define-struct fs [fsm current])
; A SimulationState.v2 is a structure: 
;   (make-fs FSM FSM-State)

; SimulationState.v2 -> Image
; renders a world state as an image 
(define (render-state.v2 s)
  empty-image)
 
; SimulationState.v2 -> SimulationState.v2
; finds the next state from a key stroke ke and current state cs
(define (find-next-state.v2 cs ke)
   cs)


; FSM FSM-State -> SimulationState.v2 
; match the keys pressed by a player with the given FSM 
(define (simulate.v2 a-fsm s0)
  (big-bang (make-fs a-fsm s0)
            (to-draw state-as-colored-square)
            (on-key  find-next-state)))

; SimulationState.v2 -> Image 
; renders current world state as a colored square 
 
(check-expect (state-as-colored-square (make-fs fsm-traffic "red"))
              (square 100 "solid" "red"))
 
(define (state-as-colored-square a-fs)
  (square 100 "solid" (fs-current a-fs)))

; SimulationState.v2 KeyEvent -> SimulationState.v2
; finds the next state from a key stroke ke and current state cs
(check-expect (find-next-state (make-fs fsm-traffic "red") "n")
              (make-fs fsm-traffic "green"))
(check-expect (find-next-state (make-fs fsm-traffic "red") "a")
              (make-fs fsm-traffic "green"))
(check-expect (find-next-state (make-fs fsm-traffic "green") "q")
              (make-fs fsm-traffic "yellow"))
(check-expect (find-next-state (make-fs fsm-traffic "yellow") "n")
              (make-fs fsm-traffic "red"))

(define (find-next-state a-fs current)
  (make-fs (fs-fsm a-fs)   
           (find (fs-fsm a-fs) (fs-current a-fs))))

; FSM FSM-State -> FSM-State
; finds the state matching current in the transition table
; [Note: completed in Exercise 199]
 
(check-expect (find fsm-traffic "red")    "green")
(check-expect (find fsm-traffic "green")  "yellow")
(check-expect (find fsm-traffic "yellow") "red")
(check-error  (find fsm-traffic "black")  "not found: black")
 
(define (find transitions current)
  (cond [(empty? transitions) 
         (error (string-append "not found: " current))]
        [(string=? (transition-current (first transitions)) current)
         (transition-next (first transitions))]
        [else (find (rest transitions) current)]))

;-- usage examples
;       any key press changes the colour of the displayed square
;
;--  with fsm-traffic
(simulate.v2 fsm-traffic "red")

;-- with fsm-bw

(define fsm-bw
  (list (make-transition "black" "white")
        (make-transition "white" "black")))


(simulate.v2 fsm-bw "black")

