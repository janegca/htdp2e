;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname EX-DifferenceInScope) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Example - Difference in scopes
(require 2htdp/abstraction)

(define width 2)

(define ex1 (for/list ([width 3] [height width]) 
              (list width height)))

; the result of ex1 is:
;
;      (list (list 0 0) (list 1 1))
;
; the 'width' variable in scope for 'height' is the one
; defined above externally (define width 2), not the
; one defined as [width 3]
; for/list traverses the two lists in parallel, stopping
;          when the end of the shortest list is reached

(define ex2 (for*/list ([width 3][height width])
              (list width height)))

; the result of ex2 is:
;
;        (list (list 1 0) (list 2 0) (list 2 1))
;
; for*/list is implicitly nested, each value of 'width'
; re-initializes height

; NOTE:
;    (for/list ([i 3] [j i]) (list i j))
;
;    produces an error "i: this variable is not defined"
;    the "i" variable in the for clause is not 'visible'
;    (not in scope) for the "j" variable
;
; however, the following(ex3) works ("i" is in scope for "j" as
; the code is implicitly nested; in pseudo-code
;    (for i= 0 to 2
;      for j= 0 to i
;          print (i j))
;
(define ex3 (for*/list ([i 3] [j i]) (list i j)))

