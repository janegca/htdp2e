;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-127-CatenateStrings) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 127. 
;
; Design the function cat, which consumes a list of strings and appends
; them all into one long string.

; List-of-Strings -> String
; combines a list of strings into a single string
(check-expect (cat (cons "a" (cons "list" (cons "of" (cons "strings" '())))))
              "alistofstrings")
(check-expect (cat '()) "")

(define (cat lst)
  (cond
    [(empty? lst) ""]
    [(cons? lst)
     (string-append (first lst) (cat (rest lst)))]))



