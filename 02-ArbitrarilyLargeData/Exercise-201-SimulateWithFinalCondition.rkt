;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-201-SimulateWithFinalCondition) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 201. 
;
; Consider the following data representation for finite state machines:

    (define-struct fsm [initial transitions final])

    ; An FSM.v2 is a structure: 
    ;   (make-fsm FSM-State LOT FSM-State)

    ; A LOT is one of: 
    ; – '() 
    ; – (cons Transition.v3 LOT)

    (define-struct transition [current key next])
    ; A Transition.v3 is a structure: 
    ;   (make-transition FSM-State FSM-State KeyEvent)

; Represent the FSM from exercise 98 in this context.
;
; Design the function fsm-simulate, which accepts an FSM.v2 and runs it on 
; a player’s key strokes. If the sequence of key strokes force the FSM.v2 to 
; reach a final state, fsm-simulate stops. Hint The function uses the initial 
; field of the given fsm structure to keep track of the current state.

; example of transition states for Exercise 98 FSM
; if a "d" is hit; just reset back to wait for another "a"
(define fsm-ex98
  (list (make-transition "white"  "a" "yellow")
        (make-transition "yellow" "b" "yellow")
        (make-transition "yellow" "c" "yellow")
        (make-transition "yellow" "d" "green")))  ; "d" triggers Final

; FSM FSM-State -> SimulationState
; match the keys pressed by a player with the given FSM 
(define (simulate initial a-fs final)
  (big-bang (make-fsm initial a-fs final)
            (to-draw   state-as-colored-square)
            (on-key    find-next-state)
            (stop-when done?)))

; SimulationState -> Boolean
; returns true if the current state equals the final state
(check-expect (done? (make-fsm "white" fsm-ex98 "green")) false)
(check-expect (done? (make-fsm "green" fsm-ex98 "green")) true)

(define (done? a-fsm)
  (string=? (fsm-initial a-fsm) (fsm-final a-fsm)))

; SimulationState -> Image 
; renders current world state as a colored square 
(check-expect (state-as-colored-square 
               (make-fsm "white" fsm-ex98 "yellow"))
              (square 100 "solid" "white"))
 
(define (state-as-colored-square a-fsm)
  (square 100 "solid" (fsm-initial a-fsm)))

; SimulationState KeyEvent -> SimulationState
; finds the next state from a key stroke ke and current state cs
(check-expect (find-next-state (make-fsm "white" fsm-ex98 "green") "a")
              (make-fsm "yellow" fsm-ex98 "green"))
(check-expect (find-next-state (make-fsm "yellow" fsm-ex98 "green") "d")
              (make-fsm "green" fsm-ex98 "green"))
(check-expect (find-next-state (make-fsm "yellow" fsm-ex98 "green") "b")
              (make-fsm "yellow" fsm-ex98 "green"))
(check-expect (find-next-state (make-fsm "yellow" fsm-ex98 "green") "c")
              (make-fsm "yellow" fsm-ex98 "green"))
(check-expect (find-next-state (make-fsm "yellow" fsm-ex98 "green") "a")
              (make-fsm "yellow" fsm-ex98 "green"))
(check-expect (find-next-state (make-fsm "white" fsm-ex98 "green") "r")
              (make-fsm "white" fsm-ex98 "green"))

(define (find-next-state a-fsm ke)
  (make-fsm (find (fsm-transitions a-fsm) 
                  (fsm-initial a-fsm) 
                  ke)
            (fsm-transitions a-fsm)
            (fsm-final      a-fsm)))

; FSM FSM-State KeyEvent -> FSM-State
; finds the state matching the current FSM-State in the transition table
(check-expect (find fsm-ex98 "white"  "a") "yellow")
(check-expect (find fsm-ex98 "yellow" "d") "green")
(check-expect (find fsm-ex98 "yellow" "x") "yellow")

(define (find trans current ke)
  (cond [(empty? trans) current]  ; no error handling as yet
        [(and (string=? current (transition-current (first trans)))
              (string=? ke (transition-key (first trans))))
         (transition-next (first trans))]
        [else (find (rest trans) current ke)]))

; -- usage example
(simulate "white" fsm-ex98 "green")
