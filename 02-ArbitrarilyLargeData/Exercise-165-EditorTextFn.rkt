;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-165-EditorTextFn) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 165.
;
; Design editor-text. That is, use the standard design recipe and do not fall 
; back on implode.

(define FONT-SIZE 16)
(define FONT-COLOR "black")

; Lo1s -> Image
; renders a list of 1Strings as a text image
(check-expect (editor-text '()) 
              (text "" FONT-SIZE FONT-COLOR))
(check-expect (editor-text (cons "c"(cons "a"(cons "t" '()))))
              (text "cat" FONT-SIZE FONT-COLOR))

;
(define (editor-text s)
  (text (cat s) FONT-SIZE FONT-COLOR))

(define (cat s)
  (cond [(empty? s) ""]
        [else (string-append (first s) (cat (rest s)))]))
