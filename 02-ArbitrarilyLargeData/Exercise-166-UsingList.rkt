;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-166-UsingList) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 166. 
;
; Use list to construct the equivalent of the following lists:
;
;    (cons "a" (cons "b" (cons "c" (cons "d" (cons "e" '())))))
;
;    (cons (cons 1 (cons 2 '())) '())
;
;    (cons "a" (cons (cons 1 '()) (cons #false '())))
;
;    (cons (cons 1 (cons 2 '())) (cons (cons 2 '()) '()))
;
;    (cons (cons "a" (cons 2 '())) (cons "hello" '()))
;
; Start by determining how many items each list and each nested list contains. 
; Use check-expect to express your answers; this ensures that your
; abbreviations are really the same as the long-hand.

(check-expect (cons "a" (cons "b" (cons "c" (cons "d" (cons "e" '())))))
              (list "a" "b" "c" "d" "e"))

(check-expect (cons (cons 1 (cons 2 '())) '())
              (list (list 1 2)))

(check-expect (cons "a" (cons (cons 1 '()) (cons #false '())))
              (list "a" (list 1) false))

(check-expect (cons (cons 1 (cons 2 '())) (cons (cons 2 '()) '()))
              (list (list 1 2) (list 2)))

(check-expect (cons (cons "a" (cons 2 '())) (cons "hello" '()))
              (list (list "a" 2) "hello"))