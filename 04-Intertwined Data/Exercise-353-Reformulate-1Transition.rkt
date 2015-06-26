;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Exercise-353-Reformulate-1Transition) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 353.
;
; Reformulate the data definition for 1Transition so that it is possible
; to restrict transitions to certain key strokes. Try to formulate the
; change so that find continues to work without change. What else do you
; need to change to get the complete program to work? Which part of the
; design recipe provides the answer(s)? See exercise 200 for the original
; exercise statement.

; A 1Transition is a structure:
;   (cons FSM-State (cons KeyEvent (cons FSM-State '())))
; interpretation: where FSM-State is the current state, KeyEvent is
; the current key press and FSM-State is the new state

; The on-key event needs to be modified to only recognize allowed
; key-presses


