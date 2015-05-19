;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-180-StringsAndWords) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 180. 
;
; The above leaves us with two additional “wishes:” a function that consumes 
; a String and produces its corresponding Word(String->Word) and a function
; for the opposite direction (Word -> String)
;
; Look up the data definition for Word in the next section and complete the 
; definitions of string->word and word->string. Hint You may wish to look 
; in the list of functions that BSL provides. 

; A Word is either 
; – '() or
; – (cons 1String Word)
; interpretation a String as a list of single Strings (letters)

; String -> Word
; convert s to the chosen word representation 
(check-expect (string->word "") '())
(check-expect (string->word "cat") (list "c" "a" "t"))

(define (string->word s)
  (cond [(string=? "" s) '()]
        [else (explode s)]))

; Word -> String
; convert w to a string
(check-expect (word->string '()) '())
(check-expect (word->string (list "c" "a" "t")) "cat")

(define (word->string w)
  (cond [(empty? w) '()]
        [else (implode w)]))

