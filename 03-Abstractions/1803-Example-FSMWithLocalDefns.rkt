;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 1803-Example-FSMWithLocalDefns) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 18.03 - Example - A Finite State Machine using Local Definitions

; A FSM is one of:
;   – '()
;   – (cons Transition FSM)
 
(define-struct transition [current next])
; A Transition is 
;   (make-transition FSM-State FSM-State)
 
; FSM-State is a String that specifies a color. 
 
; interpretation A FSM represents the transitions that a
; finite state machine can take from one state to another 
; in reaction to key strokes 

; An example of state transitions
(define fsm-traffic
  (list (make-transition "red"    "green")
        (make-transition "green"  "yellow")
        (make-transition "yellow" "red")))

; FSM FSM-State -> FSM-State
; match the keys pressed by a player with the given FSM 
 
(define (simulate fsm s0)
  (local (; State of the World: FSM-State
 
          ; NOTE: as this function is local, the state of the world
          ;       always equates to the current state of the FSM
          ;       no need to pass the FSM as an argument to
          ;       find-next-state; the function can 'see' the fsm
          ;       argument to simulate AND the gobally defined function
          ;       find
          ;       the design makes it clear that the only thing that
          ;       'changes' during program execution is the state of the
          ;       world; not the world itself
          ;       i.e. we are not constantly creating new worlds but
          ;            simply modifying an existing one
          
          ; FSM-State KeyEvent -> FSM-State
          ; finds the next state in the transition table of fsm0
          (define (find-next-state s key-event)
            (find fsm s)))
 
    ; NOW LAUNCH THE WORLD
    (big-bang s0
              [to-draw state-as-colored-square]
              [on-key  find-next-state])))
 
; FSM-State -> Image
; renders current state as colored square 
(define (state-as-colored-square s)
   (square 100 "solid" s))
 
; FSM FSM-State -> FSM-State
; finds the state matching current in the given transition table (fsm)
(define (find transitions current)
  (cond
    [(empty? transitions) (error "not found")]
    [else
      (local ((define s (first transitions)))
        (if (string=? (transition-current s) current)
            (transition-next s)
            (find (rest transitions) current)))]))

; -- usage example
(simulate fsm-traffic "red")