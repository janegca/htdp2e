;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-064-DataDefintion-Time) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 64. 
; Provide a structure type definition and a data definition for representing 
; points in time since midnight. A point in time consists of three numbers: 
; hours, minutes, and seconds. 

(define-struct time [hour minute seconds])
; A Time is a structure: (make-time Number Number Number)
; interpretation: (make-time hour minute seconds) is a point in time from
; midnight where an hour is a number between 0 and 23, with 0 hours
; representing midnight; a minute is a number between 0 and 59 and seconds
; is a number between 0 and 59.