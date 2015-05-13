;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-154-LegalPosns) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 154. 
; 
; Design the function legal. Like translate from exercise 153 the function 
; consumes and produces a list of Posns. The result contains all those Posns
; whose x coordinates are between 0 and 100 and whose y coordinates are 
; between 0 and 200. 

; List-of-Posns -> List-of-Posns
; returns all posns, from a list of Posn's, whose x-coordiante is
; between 0 and 100 and whose y-coordinate is between 0 and 200.
(check-expect (legal '()) '())
(check-expect (legal (cons (make-posn 40 40) '()))
              (cons (make-posn 40 40) '()))
(check-expect (legal (cons (make-posn 40 40)(cons (make-posn 30 210) '())))
              (cons (make-posn 40 40) '()))
(check-expect (legal (cons (make-posn 40 40) (cons (make-posn 110 40) '())))
              (cons (make-posn 40 40) '()))
(check-expect (legal (cons (make-posn 110 210)(cons (make-posn -2 -2) '())))
              '())

(define (legal lop)
  (cond [(empty? lop) '()]
        [(cons?  lop)
         (cond [(is-legal? (first lop)) 
                (cons (first lop) (legal (rest lop)))]
               [else (legal (rest lop))])]))

; Posn -> Boolean
; returns true if the x-coord is between 0 and 100 and the
; y-coord is between 0 and 200
(define (is-legal? p)
  (and (> (posn-x p) 0)
       (< (posn-x p) 100)
       (> (posn-y p) 0)
       (< (posn-y p) 200)))


