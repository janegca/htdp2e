;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-390-partition) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 390.
;
; Define the function partition. It consumes a String s and a natural
; number n. The function produces a list of string chunks of size n.
;
; For non-empty strings s and positive natural numbers n,
;
;    (equal? (partition s n) (bundle (explode s) n))
;
; is #true. But don’t use this equality as the definition for partition; use
; substring instead.
;
; Hint: Have partition produce its “natural” result for the empty string.
;       For the case where n is 0, see exercise 388.
;
; Note: The partition function is somewhat closer to what a cooperative
;       DrRacket environment would need than bundle.

; String N -> [List-of String]
; the original string broken into subsequences of size n
(check-expect (partition "abcdefg" 2) '("ab" "cd" "ef" "g"))
(check-expect (partition "ab"      3) '("ab"))
(check-expect (partition ""        3) '(""))

(define (partition s n)
  (if (> (string-length s) n)
      (cons (substring s 0 n) (partition (substring s n) n))
      (cons (substring s 0) '())))

; NOTE: this has gotta be time consuming, looking at length of
;       string each time; needed here as substring throws an
;       error if n is > string length -- haven't covered try-blocks
;       (or something similar) as yet
