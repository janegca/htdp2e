;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Exercise-351-modifyFSM) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 351.
;
; Modify the rendering function so that it overlays the name of the state onto
; the colored square.


(require 2htdp/image)
(require 2htdp/universe)

; A FSM is a [List-of 1Transition]

; A 1Transition is a list of two items:
;   (cons FSM-State (cons FSM-State '()))

; A FSM-State is a String that specifies color
 
; data examples 
(define fsm-traffic
  '(("red" "green") ("green" "yellow") ("yellow" "red")))
 
; FSM FSM-State -> FSM-State 
; match the keys pressed by a player with the given FSM 
(define (simulate state0 transitions)
  ; State of the World: FSM-State
  (big-bang state0
            [to-draw
             (lambda (current)
               (overlay (text current 12 'black)
                        (square 100 "solid" current)))]
            [on-key
             (lambda (current key-event)
               (find transitions current))]))
 
; [List-of [List X Y]] X -> Y
; finds the matching Y for the given X in the association list
(define (find alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (second fm) (error "next state not found"))))

; -- example usage
(simulate "red" fsm-traffic)
