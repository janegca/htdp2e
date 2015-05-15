;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-170-Lists2n3rd4thetc) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 170. 
;
; You know about first and rest from BSL, but BSL+ comes with even more 
; selectors than that. Determine the values of the following expressions:
;
;    (first (list 1 2 3))
;
;    (rest (list 1 2 3))
;
;    (second (list 1 2 3))
;
; Find out from the documentation whether third, fourth, and fifth exist.

(check-expect (first (list 1 2 3)) 1)
(check-expect (rest (list 1 2 3)) (list 2 3))
(check-expect (second (list 1 2 3)) 2)

(check-expect (third (list 1 2 3)) 3)
(check-expect (fourth (list 1 2 3 4)) 4)
(check-expect (fifth (list 1 2 3 4 5)) 5)
              

