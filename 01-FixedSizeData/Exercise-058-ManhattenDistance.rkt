;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-058-ManhattenDistance) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 58. 
; The Manhattan distance of a point to the origin considers a path that
; follows a rectangular grid, like those rigid blocks in Manhattan.
; When placed in such a context, one cannot walk a straight path from a 
; point to the origin; instead a person must follow the grid pattern. 
; For a point such as (3,4), a local resident might say “go three blocks 
; this way, turn right, and then go four blocks straight” to provide 
; directions to get to the origin of the grid.
;
; Design the function manhattan-distance, which measures the Manhattan 
; distance of the given posn structure to the origin. 
;
; Posn -> Number
; computes the distance from the origin position (0,0)
; to a-posn counted in grid (city) blocks 

(check-expect (manhatten-distance (make-posn 0 0)) 0)
(check-expect (manhatten-distance (make-posn 0 5)) 5)
(check-expect (manhatten-distance (make-posn 7 0)) 7)
(check-expect (manhatten-distance (make-posn 3 4)) 7)

(define (manhatten-distance a-posn) 
  (+ (posn-x a-posn) (posn-y a-posn)))
