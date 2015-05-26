;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-200-SimulateUsingExercise98) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 200. Here is a revised data definition for Transition:

    (define-struct ktransition [current key next])
    ; A Transition.v2 is a structure:
    ;   (make-ktransition FSM-State KeyEvent FSM-State)

; Represent the FSM from exercise 98 using lists of Transition.v2s; ignore 
; error and final states.
;
; Modify the design of simulate so that it deals with key strokes in the 
; appropriate manner now. Follow the design recipe, starting the adaptation
; of the data examples.
; 
; Use the revised program to simulate a run of the FSM from exercise 98 on 
; the following sequence of key strokes: "a", "b", "b", "c", and "d". 

; A FSM is one of:
;   – '()
;   – (cons Transition FSM)

; FSM-State is a String that specifies a color. 

; interpretation: A FSM represents the transitions that a
; finite state machine can take from one state to another 
; in reaction to key strokes 

; example of transition states for Exercise 98 FSM
; if a "d" is hit; just reset back to wait for another "a"
(define fsm-ex98
  (list (make-ktransition "white"  "a" "yellow")
        (make-ktransition "yellow" "b" "yellow")
        (make-ktransition "yellow" "c" "yellow")
        (make-ktransition "yellow" "d" "white")))

(define-struct fs [fsm current])
; A SimulationState is a structure: 
;   (make-fs FSM FSM-State)

; FSM FSM-State -> SimulationState
; match the keys pressed by a player with the given FSM 
(define (simulate a-fsm s0)
  (big-bang (make-fs a-fsm s0)
            (to-draw state-as-colored-square)
            (on-key  find-next-state)))

; SimulationState -> Image 
; renders current world state as a colored square 
(check-expect (state-as-colored-square (make-fs fsm-ex98 "yellow"))
              (square 100 "solid" "yellow"))
 
(define (state-as-colored-square a-fs)
  (square 100 "solid" (fs-current a-fs)))

; SimulationState KeyEvent -> SimulationState
; finds the next state from a key stroke ke and current state cs
(check-expect (find-next-state (make-fs fsm-ex98 "white") "a")
              (make-fs fsm-ex98 "yellow"))
(check-expect (find-next-state (make-fs fsm-ex98 "yellow") "d")
              (make-fs fsm-ex98 "white"))
(check-expect (find-next-state (make-fs fsm-ex98 "yellow") "b")
              (make-fs fsm-ex98 "yellow"))
(check-expect (find-next-state (make-fs fsm-ex98 "yellow") "c")
              (make-fs fsm-ex98 "yellow"))
(check-expect (find-next-state (make-fs fsm-ex98 "yellow") "a")
              (make-fs fsm-ex98 "yellow"))
(check-expect (find-next-state (make-fs fsm-ex98 "white") "r")
              (make-fs fsm-ex98 "white"))
                               
(define (find-next-state a-fs ke)
  (make-fs (fs-fsm a-fs)
           (find (fs-fsm a-fs) (fs-current a-fs) ke)))
           
; FSM FSM-State KeyEvent -> FSM-State
; finds the state matching the current FSM-State in the transition table
(check-expect (find fsm-ex98 "white"  "a") "yellow")
(check-expect (find fsm-ex98 "yellow" "d") "white")
(check-expect (find fsm-ex98 "yellow" "x") "yellow")

(define (find trans current ke)
  (cond [(empty? trans) current]  ; no error handling as yet
        [(and (string=? current (ktransition-current (first trans)))
              (string=? ke (ktransition-key (first trans))))
         (ktransition-next (first trans))]
        [else (find (rest trans) current ke)]))

; -- usage example
(simulate fsm-ex98 "white")