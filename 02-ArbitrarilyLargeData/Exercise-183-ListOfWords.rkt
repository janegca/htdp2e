;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-183-ListOfWords) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 183. 
; 
; Write down the data definition for List-of-words. Systematically make up
; examples of Words and List-of-words. Finally, formulate the functional
; example from above with check-expect. Instead of working with the full
; example, you may wish to start with a word of just two letters, say "d" 
; and "e". 

; A List-of-words (LOW) is one of:
; - '() or
; - (cons Word LOW)
; interpretation: a LOW is a list of Words

; A Word is either
; – '() or
; – (cons 1String Word)
; interpretation a String as a list of single Strings (letters)

(define w1 (list "c" "a" "t"))
(define w2 (list "r" "a" "t"))
(define w3 (list "d" "e" "a" "r"))
(define low1 (list w1 w2 w3))
  
; Word -> List-of-words
; find all re-arrangements of word
(check-expect (arrangements (list "d"))
              (list (list "d")))
(check-expect (arrangements (list "d" "e"))
              (list (list "d" "e") (list "e" "d")))

(define (arrangements word) 
  (list word))

