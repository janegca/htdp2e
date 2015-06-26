;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-354-BWExample) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 354.
;
; Formulate an XML configuration for a machine that switches from white to
; black and back for every key event and then translate it into an XMachine
; representation. See exercise 198 for an implementation of the machine as a
; program.

; An XMachine is:
;   (list 'machine (list (list 'initial FSM-State)) [List-of X1T])

; An X1T is
;   (list 'action (list (list 'state FSM-State) (list 'next FSM-State)))

; <machine initial="white">
;   <action state="white" next="black" />
;   <action state="black" next="white" />
; </machine>

'(machine ((initial "white"))
          (action ((state "white") (next "black")))
          (action ((state "black") (next "white"))))

           