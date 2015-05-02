;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-068-HMS) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 68. 
; Design the function time->seconds, which consumes instances of the time 
; structures developed in exercise 64 and produces the number of seconds 
; that have passed since midnight. For example, if you are representing 12
; hours, 30 minutes, and 2 seconds with one of these structures and if you
; then apply time->seconds to this instance, the correct result is 45002.

(define-struct time [h m s])
; Time is a structure: (make-time Number Number Number)
; - h is a number between 0 and 23 representing hours   in a  day
; - m is a number between 0 and 59 representing minutes in an hour
; - s is a number between 0 and 59 representing seconds in a  minute

; Time -> Number
; converts a given time to seconds
(check-expect (time->seconds (make-time 12 30 2)) 45002)

(define (time->seconds t)
  (+ (* (time-h t) 3600)  ; 3600 = 60' * 60"
     (* (time-m t) 60) 
     (time-s t)))



