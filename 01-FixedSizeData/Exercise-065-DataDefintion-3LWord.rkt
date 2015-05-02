;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-065-DataDefintion-3LWord) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 65. 
; Provide a structure type definition and a data definition for representing
; lower-case three-letter words. A word consists of letters, represented with 
; the one-letter strings "a" through "z".

(define-struct 3LWord [s1 s2 s3])
; A 3LWord is a structure: (make-3LWord String String String)
; interpretation: (make-3LWord s1 s2 s3) is a three letter word where each
; of s1, s2, s3 is a one-letter string "a" through "z".