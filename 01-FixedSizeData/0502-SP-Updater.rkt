;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0502-SP-Updater) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 05.02 - Sample Problem - Updater
;
; Design the function posn-up-x, which consumes a Posn p and a Number n. 
; It produces a Posn like p with n in the x field.

; Posn Number -> Posn
; updates x coordinate of p with n
(check-expect (posn-up-x (make-posn -10 22) 100)             
              (make-posn 100 22))

(define (posn-up-x p n)  
  (make-posn n (posn-y p)))

; we can define x+ using posn-up-x

; Posn -> Posn
; increases the x coordinate of p by 3
(check-expect (x+ (make-posn 10 0)) (make-posn 13 0))

(define (x+ p)  
  (posn-up-x p (+ (posn-x p) 3)))

; we can something similar for y 

; Posn Number -> Posn
; updates y-coordinate with n
(check-expect (posn-down-y (make-posn 10 30) 40)
              (make-posn 10 40))
                            
(define (posn-down-y p n)  
  (make-posn (posn-x p) n))

; Posn -> Posn
; decreases the y coordinate of p by 3
(check-expect (y- (make-posn 0 10)) (make-posn 0 7))

(define (y- p)
  (posn-down-y p (- (posn-y p) 3)))