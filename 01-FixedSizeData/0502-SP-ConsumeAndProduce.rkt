;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0502-SP-ConsumeAndProduce) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 05.02 - Sample Problem - ConsumeAndProduce
;
; Design the functions x+ and y-. The former consumes a Posn and increases 
; the x coordinate by 3; the latter consumes a Posn and decreases the y 
; coordinate by 3.

; Posn -> Posn
; increases the x coordinate of p by 3
(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))

(define (x+ p)  
  (make-posn (+ (posn-x p) 3) (posn-y p)))

; Posn -> Posn
; decreases the y coordinate of p by 3
(check-expect (y- (make-posn 0 10)) (make-posn 0 7))

(define (y- p)
  (make-posn (posn-x p) (- (posn-y p) 3)))

