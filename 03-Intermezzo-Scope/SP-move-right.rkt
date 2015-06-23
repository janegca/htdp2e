;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname SP-move-right) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Sample Problem:
;
; Use match to design the function move-right. The latter consumes a list of
; Posns, which represent the positions of objects on a canvas, plus a number.
; It adds the latter to each x coordinate, which represents an rightward
; movement of these objects.

(require 2htdp/abstraction)

; [List-of Posn] -> [List-of Posn] 
; moves each object right by delta-x pixels
(check-expect (move-right (list (make-posn 1 1) (make-posn 10 14)) 3)
              (list (make-posn 4 1) (make-posn 13 14)))

(define (move-right lop delta-x)
  (map (lambda (p)
         (match p
           [(posn x y) (make-posn (+ x delta-x) y)]))
       lop))

; NOTE: match is overkill here, can use
(check-expect (move-right.v1 (list (make-posn 1 1) (make-posn 10 14)) 3)
              (list (make-posn 4 1) (make-posn 13 14)))

(define (move-right.v1 lop delta-x)
  (map (lambda (p)
         (make-posn (+ (posn-x p) delta-x) (posn-y p)))
       lop))

; alternative solution using abstraction
(check-expect (move-right.v2 (list (make-posn 1 1) (make-posn 10 14)) 3)
              (list (make-posn 4 1) (make-posn 13 14)))

(define (move-right.v2 lop delta-x)
  (cond [(empty? lop) '()]
        [else (cons (make-posn (+ (posn-x (first lop)) delta-x)
                               (posn-y (first lop)))
                    (move-right.v2 (rest lop) delta-x))]))

; an alternative solution using higher-order function
(check-expect (move-right.v3 (list (make-posn 1 1) (make-posn 10 14)) 3)
              (list (make-posn 4 1) (make-posn 13 14)))

(define (move-right.v3 lop delta-x)
  (local ((define (mr p)
            (make-posn (+ (posn-x p) delta-x)
                       (posn-y p))))
    (map mr lop)))

