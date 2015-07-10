;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 3103-EX-FileParsing) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 31.03 - Example - File Parsing

; A File is one of: 
; – '()
; – (cons "\n" File)
; – (cons 1String File)
; interpretation "\n" represents the newline character

; A Line is [List-of 1String]

; File -> [List-of Line]
; converts a file into a list of lines 
 
(check-expect (file->list-of-lines '("\n" "\n"))
              '(() ()))
 
(check-expect (file->list-of-lines
                (list "a" "b" "c" "\n" "d" "e" "\n" "f" "g" "h" "\n"))
              (list (list "a" "b" "c")
                    (list "d" "e")
                    (list "f" "g" "h")))
 
(define (file->list-of-lines afile)
  (cond
    [(empty? afile) '()]
    [else
      (cons (first-line afile)
            (file->list-of-lines (remove-first-line afile)))]))
 
; File -> Line
; retrieves the prefix of afile up to the first occurrence of NEWLINE
(define (first-line afile)
  (cond
    [(empty? afile) '()]
    [(string=? (first afile) NEWLINE) '()]
    [else (cons (first afile) (first-line (rest afile)))]))
 
; File -> Line
; drops the suffix of afile behind the first occurrence of NEWLINE
(define (remove-first-line afile)
  (cond
    [(empty? afile) '()]
    [(string=? (first afile) NEWLINE) (rest afile)]
    [else (remove-first-line (rest afile))]))
 
(define NEWLINE "\n")
