;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 1804-SP-UsingAbstractions-ormap) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 18.04 - Sample Problem - Using Abstractions - ormap

; Design a function that determines whether any of a list of Posns is close 
; to some given position pt where “close” means a distance of at most 5 pixels.

; [List-of Posn] -> Boolean

(check-expect (close? (list (make-posn 47 54) (make-posn 0 60))
                      (make-posn 50 50))
              #true)

(define (close? lop pt)
  (local (; Posn -> Boolean
          ; is one shot close to pt
          (define (is-one-close? p)
            (close-to? p pt CLOSENESS)))
    ; - IN -
    
    ; NOTE: ormap traverses a list of booleans until it finds an 
    ;       element equal to #true or reaches the end, in which
    ;       case, it returns #false
  
    (ormap is-one-close? lop)))
 
(define CLOSENESS 5)

; NOTE: close-to? is defined globally as it applicable to
;       any two positions, not just those defined within a list
;       of positions i.e. it can be used in a wide variety of
;       situations and not solely in the context described by close? 

; Posn Posn Number -> Boolean
; returns true if the two positions are within range of each other
; using the given tolerance
(define (close-to? m n tolerance)
  (<= (sqrt (+  (sqr (- (posn-x m) (posn-x n))) 
                (sqr (- (posn-y m) (posn-y n)))))
       tolerance))