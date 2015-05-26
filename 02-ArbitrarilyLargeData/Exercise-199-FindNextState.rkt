;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-199-FindNextState) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 199. 
;
; Complete the design of find.

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

; FSM FSM-State -> FSM-State
; finds the state matching current in the transition table
 
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


