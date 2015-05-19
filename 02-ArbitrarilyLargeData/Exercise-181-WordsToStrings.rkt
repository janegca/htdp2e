;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-181-WordsToStrings) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 181. 
;
; Complete the design of the words->strings function specified in figure 50. 
; Hint Use your solution to exercise 180.

; List-of-words -> List-of-strings
; turn all Words in low into Strings 
(check-expect (words->strings '()) '())
(check-expect (words->strings (list (list "c" "a" "t") 
                                    (list "r" "a" "t")))
              (list "cat" "rat"))

(define (words->strings low) 
  (cond [(empty? low) '()]
        [else (cons (word->string (first low)) 
                    (words->strings (rest low)))]))

; Word -> String
; convert w to a string
(check-expect (word->string '()) '())
(check-expect (word->string (list "c" "a" "t")) "cat")

(define (word->string w)
  (cond [(empty? w) '()]
        [else (implode w)]))










