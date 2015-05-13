;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-153-Translate) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 153. 
;
; Design the function translate. It consumes and produces lists of Posns. 
; For each (make-posn x y) in the former, the latter contains
; (make-posn x (+ y 1)). — We borrow the word “translate” from geometry,
; where the movement of a point by a constant distance along a straight 
; line is called a translation.

; List-of-Posns -> List-of-Posns
; translates a list of Posn's by moving all posns one point on the y-axis
(check-expect (translate '()) '())
(check-expect (translate (cons (make-posn 1 1) '()))
              (cons (make-posn 1 2) '()))
(check-expect (translate (cons (make-posn 1 1)(cons (make-posn 1 -1) '())))
              (cons (make-posn 1 2)(cons (make-posn 1 0) '())))

(define (translate lop)
  (cond [(empty? lop) '()]
        [(cons?  lop)
         (cons (make-posn (posn-x (first lop))
                          (+ 1 (posn-y (first lop))))
               (translate (rest lop)))]))


