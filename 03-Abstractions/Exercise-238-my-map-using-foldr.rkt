;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-238-my-map-using-foldr) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 238. 
; 
; The fold functions are so powerful that you can define almost any 
; list-processing functions with them. Use fold to define map.
;
; NOTE: reference HtDP first edition solution to Exercise 21.1.1
;       http://www.htdp.org/2003-09-26/Solutions/abs-sum-prod.html

(check-expect (my-map add1 '()) '())
(check-expect (my-map add1 (list 1 2 3)) (map add1 (list 1 2 3)))

(define (my-map f lst)
  (local ( (define (cmb fst rst)
             (cons (f fst) rst)))
    (foldr cmb '() lst)))
           

