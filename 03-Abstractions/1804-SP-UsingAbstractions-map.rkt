;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 1804-SP-UsingAbstractions-map) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 18.04 - Sample Problem - Using Abstractions - map

; Design the function add-3-to-all. The function consumes a list of Posns 
; and adds 3 to the x coordinates of each of them.

; [List-of Posn] -> [List-of Posn]
; adds 3 to each x coordinate on the given list 
 
(check-expect (add-3-to-all (list (make-posn 30 10) (make-posn 0 0)))
              (list (make-posn 33 10) (make-posn 3 0)))
 
; NOTE: the higher order function 'map' applies the local function,
;       add-3-to-one, to every element of the list (lop)
;       i.e.   (map add-3-to-one lop)
;           == (cons (add-3-to-one (first lop))
;                    (add-3-to-one (rest  lop)))
;           == (list (add-3-to-one x1) 
;                    (add-3-to-one x2) ... (add-3-to-one xn))
;           == (list z1 z2 ... zn)
;       where, x1 ... xn equal the original list elements
;              z1 ... zn equal x1 ... xn after add-3-to-one has been applied

(define (add-3-to-all lop)
  (local (; Posn -> Posn
          ; adds 3 to the x coordinate of the given Posn
          (define (add-3-to-one p)
            (make-posn (+ (posn-x p) 3) (posn-y p))))
    ; - IN -
    (map add-3-to-one lop)))



