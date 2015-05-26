;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-198-BWMachineDataExample) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 198. 
; 
; The BW Machine is a FSM that flips from black to white and back to black for 
; every key event. Formulate a data representation for the BW Machine. 

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

; Example of a BW machine

(define fsm-bw
  (list (make-transition "black" "white")
        (make-transition "white" "black")))


