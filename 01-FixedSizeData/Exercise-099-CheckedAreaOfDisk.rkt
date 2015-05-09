;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-099-CheckedAreaOfDisk) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 99. 
; A checked version of area-of-disk can also enforce that the arguments to 
; the function are positive numbers, not just arbitrary numbers. Modify 
; checked-area-of-disk in this way.

; Number -> Number
; computes the area of a disk with radius r
(check-expect (area-of-disk 3) 28.26)

(define (area-of-disk r)  
  (* 3.14 (* r r)))

; Any -> Number
; computes the area of a disk with radius v, 
; if v is a number
(check-expect (checked-area-of-disk 3) 28.26)
(check-error  (checked-area-of-disk -3) 
              "area-of-disk: number expected")
(check-error  (checked-area-of-disk "3")
              "area-of-disk: number expected")

(define (checked-area-of-disk v)  
  (cond    [(and (number? v) (>= v 0)) (area-of-disk v)]    
           [else (error "area-of-disk: number expected")]))
