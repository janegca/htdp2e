;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0204-Example-InteractiveProgram) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; 02.04 Example of an interactive program
(define (main y)
  (big-bang y                           ; starts a world in the given state
            [on-tick   sub1]            ; subtract 1 from y at each clock tick
            [stop-when zero?]           ; stop when y = 0
            [to-draw   place-dot-at]    ; render world with dot at new position
            [on-key    stop]))          ; stop on any key-press

(define (place-dot-at y)
  (place-image (circle 3 "solid" "red") 50 y (empty-scene 100 100)))

(define (stop y ke) 0 )

; usage example
(main 90)