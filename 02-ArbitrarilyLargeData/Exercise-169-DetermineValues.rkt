;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-169-DetermineValues) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 169. 
; 
; Determine the values of the following expressions:
;
;    (list (string=? "a" "b") (string=? "c" "c") #false)
;
;    (list (+ 10 20) (* 10 20) (/ 10 20))
;
;    (list "dana" "jane" "mary" "laura")
;
; Use check-expect to express your answers.

(check-expect (list (string=? "a" "b") (string=? "c" "c") #false)
              (list false true false))

(check-expect (list (+ 10 20) (* 10 20) (/ 10 20))
              (list 30 200 1/2))

(check-expect (list "dana" "jane" "mary" "laura")
              (list "dana" "jane" "mary" "laura"))

