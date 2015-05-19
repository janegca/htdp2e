;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-182-CompleteInDictionary) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 182. 
;
; Complete the design of the in-dictionary function specified in figure 50.
; Hint Figure 49 shows how to turn the 2htdp/batch-io library to read the
; dictionary on your computer into a list of strings. 
;

(define DICTIONARY-LOCATION "words.txt")
(define DICTIONARY-AS-LIST (read-lines DICTIONARY-LOCATION))

; List-of-strings -> List-of-strings
; pick out all those Strings that occur in the dictionary 
(check-expect (in-dictionary '()) '())
(check-expect (in-dictionary (list "act" "tca" "cat"))
              (list "act" "cat"))

(define (in-dictionary los) 
  (cond [(empty? los) '()]
        [(member? (first los) DICTIONARY-AS-LIST)
                  (cons (first los) (in-dictionary (rest los)))]
        [else (in-dictionary (rest los))]))

