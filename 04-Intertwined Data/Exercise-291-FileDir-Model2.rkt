;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-285-FileDir-Model2) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 291.
;
; Translate the directory tree in figure 74 into a data representation 
; according to model 2.

; -- Data Definitions
; A Dir.v2 is a structure: 
;   (make-dir Symbol LOFD)
 
; A LOFD (short for list of files and directories) is one of:
; – '()
; – (cons File.v2 LOFD)
; – (cons Dir.v2 LOFD)
 
; A File.v2 is a Symbol. 

; -- Data Structures
(define-struct dir [name content])

(define Docs (make-dir 'Docs '(read!)))
(define Code (make-dir 'Code '(hang draw)))
(define Libs (make-dir 'Libs (list Docs Code)))
(define Text (make-dir 'Text '(part1 part2 part3)))
(define TS   (make-dir 'read! (list Text Libs)))
