;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-157-Collapse) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 157.
; 
; Design a program that converts a list of lines into a string. The strings
; should be separated by blank spaces (" "). The lines should be separated 
; with a newline ("\n").
;
; Challenge: Remove all extraneous white spaces in your version of the Piet
; Hein poem. When you are finished with the design of the program, use it like
; this:
;
;    (write-file "ttt.dat" (collapse (read-words/line "ttt.txt")))
;
; The two files "ttt.dat" and "ttt.txt" should be identical.

; LLS -> String
; collapse a list of a list of strings into a single string
(define lls1 (cons (cons "TTT" '())
      (cons (cons "Put" (cons "up" (cons "in" (cons "a" (cons "place" '())))))
            (cons (cons "los" (cons "2" '()))
                  '()))))

(check-expect (collapse '()) "")
(check-expect (collapse (cons "TTT" '())) "TTT \n")
(check-expect (collapse 
               (cons (cons "TTT" '())
                     (cons (cons "Put" (cons "up" (cons "in" '())))
                           (cons (cons "los" (cons "2" '()))
                                 '()))))
              "TTT \nPut up in \nlos 2 \n")

(define (collapse lls) 
  (cond [(empty? lls) ""]
        [(cons?  lls)
         (cond [(cons? (first lls))
                (string-append (collapse-line (first lls))
                               (collapse (rest lls)))]
               [else (string-append (first lls) " \n")])]))

(define (collapse-line los) 
  (cond [(empty? los) "\n"]
        [(cons?   los)
         (string-append (first los) " " (collapse-line (rest los)))]))


; Following worked after deleting all blank lines from "ttt.txt"
;     (write-file "ttt.dat" (collapse (read-words/line "ttt.txt")))
; The "ttt.dat" matched "ttt.txt"

