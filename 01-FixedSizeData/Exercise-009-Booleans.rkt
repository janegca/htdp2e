;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-009-Booleans) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise-009
; You decide to go to the mall only if it is not sunny or Friday.
; Given the below definitions for sunny and friday, define an
; expression that computes whether sunny is false or friday is true
; Answer s/b false

(define sunny  #true)
(define friday #false)

(define goToMall (not (or (not sunny) (not friday))))
