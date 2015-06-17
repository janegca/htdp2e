;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-283-FileDir-Model1) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 289.
; 
; Translate the directory tree in figure 74 into a data representation 
; according to model 1.

; A Dir.v1 (short for directory) is one of: 
; – '()
; – (cons File.v1 Dir.v1)
; – (cons Dir.v1  Dir.v1)
 
; A File.v1 is a Symbol. 

'(read! 
     (part1 part2 part3)
     ((hang draw) (read!)))

                 