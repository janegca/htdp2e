;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 1804-SP-UsingAbstractions-filter) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 18.04 - Sample Problem - Using Abstractions - filter

;  Design a function that eliminates all Posns from a list that have a y 
;  coordinate of larger than 100.

; [List-of Posn] -> [List-of Posn]
; eliminates Posns whose y coordinate is larger than 100
 
(check-expect (keep-good (list (make-posn 0 110) (make-posn 0 60)))
              (list (make-posn 0 60)))
 
(define (keep-good lop)
  (local (; Posn -> Posn
          ; should this Posn stay on the list
          (define (good? p)
            (< (posn-y p) 100)))
    (filter good? lop)))


