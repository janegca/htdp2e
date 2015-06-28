;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |EX-Representing Numbers|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Example - Representing Numbers

(define-struct inex [mantissa sign exponent])
; An Inex is a structure: 
;   (make-inex N99 S N99)

; An S is either 1 or -1

; An N99 is an N between 0 and 99 inclusive

; N Number N -> Inex
; make an instance of Inex after checking the arguments
(define (create-inex m s e)
  (cond
    [(and (<= 0 m 99) (<= 0 e 99) (or (= s 1) (= s -1)))
     (make-inex m s e)]
    [else
     (error 'inex "(<= 0 m 99), s in {+1,-1}, (<= 0 e 99) expected")]))
 
; Inex -> Number
; convert an inex into its numeric equivalent 
(define (inex->number an-inex)
  (* (inex-mantissa an-inex)
     (expt 10 (* (inex-sign an-inex) (inex-exponent an-inex)))))

; -- Example numbers
(define n1 (create-inex 12  1 2))    ; 12e2 = 1200

(define n2 (create-inex 50 -1 20))   ; 50e-20
(define n3 (create-inex 5  -1 19))   ; 5e-19

; how they look
(inex->number n2)
(inex->number n3)

; how they compare
(eq?  (inex->number n2) (inex->number n3))
(eqv? (inex->number n2) (inex->number n3))

; delimiting the range of numbers that can be represented
; values that are inbetween representations are rounded
; ie (create-inex 12 1 2) = 1200
;    (create-inex 13 1 2) = 1300
;    we can not directly represent 1240 or 1270, need to choose
;    the nearest representation ie 1200 or 1300
(define MAX-POSITIVE (create-inex 99 1 99))
(define MIN-POSITIVE (create-inex 1 -1 99))

; Arithmetic operations
; need to be represented in correct terms
; Adding two Inex values with same exponents, just add the mantissa's
; eg  (inex+ (create-inex 1 1 0)
;            (create-inex 2 1 0))
;            -------------------
;  ->        (create-inex 3 1 0)
;
; if the resulting mantissa is too large, divide by 10 and add 1 to the
; exponent
; eg (inex+ (create-inex 55 1 0)
;           (create-inex 55 1 0))
;           --------------------
;  ->                   110 1 0
;  ->       (create-inex 11 1 1)
;
; If the division by 10 creates a decimal number, we have to round to
; nearest representation
; eg (inex+ (create-inex 56 1 0)
;           (create-inex 56 1 0))
;           --------------------
;  ->                   112 1 0
;  ->        112 / 10  11.2 1 0      -- can't represent the .2
;  ->       (create-inex 11 1 1)     -- so take nearest mantissa
;
;
; Multiplication
; Multiply the mantissa's and add the exponents
; eg (inex* (create-inex  2 1  4)
;           (create-inex  8 1 10))
;           --------------------
;           (create-inex 16 1 14)
;
; and, as in addition, if the mantissa is too large, we need to
; divide by 10 and add one to the exponent
; eg (inex* (create-inex  20 1 1)
;           (create-inex   5 1 4))
;           --------------------
;                        100 1 5   <- need to div mantissa by 10
;           (create-inex  10 1 6)
;
; and, again, need to approximate if we can't represent the mantissa fully
;
; eg (inex* (create-inex  27 -1 1)  <- exponent is a negative value
;           (create-inex   7  1 4))
;           ---------------------
;                        189  1 3   <- need to div mantissa by 10
;                       18.9  1 3   <- round to nearest value and add 1 to exp
;           (create-inex  19  1 4)
;



