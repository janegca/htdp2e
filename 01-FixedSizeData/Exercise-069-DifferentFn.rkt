;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-069-DifferentFn) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
;Exercise 69.
;
; Design the function different. It consumes two (representations of) 
; three-letter words and creates a word from the differences. For each 
; position in the words, it uses the letter from the second word if the
; two are the same; otherwise it uses the marker "*". Note The problem 
; statement mentions two different tasks: one concerning words and one 
; concerning letters. This suggests that you design two functions.

(define-struct 3LWord [s1 s2 s3])
; A 3LWord is a structure: (make-3LWord String String String)
; interpretation: (make-3LWord s1 s2 s3) is a three letter word where each
; of s1, s2, s3 is a one-letter string i.e. one character.

; 3LWord 3LWord -> 3LWord
; creates a 3LWord that is the same as s2 if s1 and s2 are equal
; otherwise, returns a new 3LWord with position of different
; letters marked by an asterisk
(check-expect (different (make-3LWord "c" "a" "t") 
                         (make-3LWord "c" "a" "r"))
              (make-3LWord "c" "a" "*"))
(check-expect (different (make-3LWord "c" "a" "t")
                         (make-3LWord "d" "o" "g"))
              (make-3LWord "*" "*" "*"))
(check-expect (different (make-3LWord "c" "a" "t")
                         (make-3LWord "c" "a" "t"))
              (make-3LWord "c" "a" "t"))

(define (different w1 w2) 
  (make-3LWord (cmp-letters (3LWord-s1 w1) (3LWord-s1 w2))
               (cmp-letters (3LWord-s2 w1) (3LWord-s2 w2))
               (cmp-letters (3LWord-s3 w1) (3LWord-s3 w2))))

; String String -> String
; returns s2 if s1 and s2 are equal, otherwise, returns "*"
(check-expect (cmp-letters "a" "b") "*")
(check-expect (cmp-letters "a" "a") "a")
(check-expect (cmp-letters "a" "")  "*")

(define (cmp-letters s1 s2)
  (if (string=? s1 s2) s2 "*"))

