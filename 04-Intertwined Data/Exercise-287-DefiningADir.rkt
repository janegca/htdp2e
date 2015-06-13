;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-287-DefiningADir) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 287. 
; 
; Show how to equip a directory with two more attributes: size and readability.
; The former measures how much space the directory itself (as opposed to its
; files and subdirectories) consumes; the latter specifies whether anyone else
; besides the user may browse the content of the directory.


(define-struct dir [name content size readability])
; A Dir is a structure: (make-dir Symbol LOFD Number String)
; interpretation: (make-dir n c s r) combines a directory's name,
; contents, space requirements and read-write access
;
; A LOFD (short for list of files and directories) is one of:
; – '()
; – (cons File.v2 LOFD)
; – (cons Dir.v2 LOFD)

; A File.v2 is a Symbol. 