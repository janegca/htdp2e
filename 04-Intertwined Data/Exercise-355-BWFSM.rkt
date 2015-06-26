;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-355-BWFSM) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 355.
;
; Run the code in figure 84 with the BW Machine configuration from
; exercise 354.

; -- example used in check-expects of Figure 84 code
(define fsm-traffic
  '(("red" "green") ("green" "yellow") ("yellow" "red")))

(define xm0
  '(machine ((initial "red"))
            (action ((state "red") (next "green")))
            (action ((state "green") (next "yellow")))
            (action ((state "yellow") (next "red")))))

; -- code from Figure 84

; XMachine -> FSM-State 
; interprets the given configuration as a state machine 
(define (simulate-xmachine xm)
  (simulate(xm-state0 xm) (xm->transitions xm)))
 
; XMachine -> FSM-State 
; extracts and translate the transition table from a configuration
 
(check-expect (xm-state0 xm0) "red")
 
(define (xm-state0 xm0)
  (lookup-attribute (xexpr-attributes xm0) 'initial))
 
; XMachine -> [List-of 1Transition]
; extracts the transition table from an XML configuration
 
(check-expect (xm->transitions xm0) fsm-traffic)
 
(define (xm->transitions xm)
  (local (; X1T -> 1Transition
          (define (xaction->action xa)
            (list (lookup-attribute (xexpr-attributes xa) 'state)
                  (lookup-attribute (xexpr-attributes xa) 'next))))
    (map xaction->action (xexpr-content xm))))

; -- required functions from earlier exercises
(require 2htdp/abstraction)

; Xexpr.v2 -> [List-of Xexpr.v2]
; retrieves the list of contents for xe
(define (xexpr-content xe)
  (match xe
    [(cons n '()) '()]               ; no optional values
    [(cons n (cons '() rest)) rest]  ; empty attribute list
    [(cons n (cons a rest))          ; one or more optional values
     (if (list? (first a))           ; is the first an attrib list?
         rest                        ; yes
         (cons a rest))]))           ; no

; [List-of Attribute] Symbol -> String
; the string value of the given symbol, if found, otherwise #false
(define (lookup-attribute a* s) 
  (local ((define res (assq s a*))) ; assq matches 1st item in a pair
    (if (cons? res)
        (second res)
        res)))

; Xexpr.v2 -> [List-of Attribute]
; retrieves the list of attributes of xe
(define (xexpr-attributes xe)
  (match xe
    [(cons sym '()) '()]              ; no optional values
    [(cons sym (cons '() rest)) '()]  ; no attributes, contents option  
    [(cons n (cons a '()))            ; one optional value
     (if (list? (first a)) a '())]    ; attribs or content?
    [(cons n (cons a rest)) a]))      ; both options


; -- FSM code from Exercise 351
(require 2htdp/image)
(require 2htdp/universe)

; A FSM is a [List-of 1Transition]

; A 1Transition is a list of two items:
;   (cons FSM-State (cons FSM-State '()))

; A FSM-State is a String that specifies color
  
; FSM FSM-State -> FSM-State 
; match the keys pressed by a player with the given FSM 
(define (simulate state0 transitions)
  ; State of the World: FSM-State
  (big-bang state0
            [to-draw
             (lambda (current)
               (overlay (text current 12 'red)
                        (square 100 "solid" current)))]
            [on-key
             (lambda (current key-event)
               (find transitions current))]))
 
; [List-of [List X Y]] X -> Y
; finds the matching Y for the given X in the association list
; NOTE: revised to avoid use of 'assoc' from ASL
(define (find alist x)
  (cond [(empty? alist) (error "next state not found")]
        [(equal? (first (first alist)) x) (second (first alist))]
        [else (find (rest alist) x)]))

; -- example code from Exercise 354
(define bw '(machine ((initial "white"))
                       (action ((state "white") (next "black")))
                       (action ((state "black") (next "white")))))


(simulate-xmachine bw)
