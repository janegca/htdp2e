;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-419-tokenize) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 419.
;
; Design the function tokenize. It turns a Line into a list of tokens. Here a
; token is either a 1String or a String that consists of lower-case letters
; and nothing else. That is, all white-space 1Strings are dropped; all other
; non-letters remain as is; and all consecutive letters are bundled into
; “words.” Hint Read up on the string-whitespace? function.

; A Line is [List-of 1String]

; A Token is one of:
; - 1String (no whitespace characters)
; - String of (lowercase letters only)

; Line -> [List-of Token]
; converts a line to a list of tokens

(check-expect (tokenize '()) '())
(check-expect (tokenize '("")) '())
(check-expect (tokenize '("c" "a" "t")) '("cat"))
(check-expect (tokenize '("o" "n" "e" " " "f" "o" "r" " " "a" "l" "l"))
              '("one" "for" "all"))
(check-expect (tokenize '("1" "f" "o" "r" " " "a" "l" "l"))
              '("1" "for" "all"))
(check-expect (tokenize '("g" "o" "o" "d" "4" "y" "o" "u"))
              '("good" "4" "you"))

(define (tokenize ln)
  (cond [(empty? ln) '()]
        [(string-whitespace? (first ln)) (tokenize (rest ln))]
        [(string-lower-case? (first ln))
         (cons (implode (bld-word ln)) (drop-word ln))]
        [else (cons (first ln) (tokenize (rest ln)))]))

(define (bld-word ln)
  (cond [(empty? ln) '()]
        [(string-lower-case? (first ln))
         (cons (first ln) (bld-word (rest ln)))]
        [else '()]))

(define (drop-word ln)
  (cond [(empty? ln) '()]
        [(string-lower-case? (first ln)) (drop-word (rest ln))]
        [else (tokenize ln)]))

                    
  

                             
        
        