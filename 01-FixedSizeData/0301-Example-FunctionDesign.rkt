;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0301-Example-FunctionDesign) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Examples of stub functions

; String -> Number
(define (f a-string) 0)

; Number -> String
(define (g n) "a")

; Number String Image -> Image
; adds s to img, y pixels from top, 10 pixels from left
; given: 5 for y, "hello" for s, (empty-scene 100 100) for img
; expected: (place-image (text "hello" 10 "red") 10 5 (empty-scene 100 100))
(define (add-image y s img)
  (place-image (text s 10 "red") 10 y img))

; Number -> Number
; compute the area of a square whose side is len
; given: 2, expect: 4
; given: 7, expect: 49
(define (area-of-square len) 
  (sqr len))

; usage examples
(add-image 5 "hello" (empty-scene 100 100))
(area-of-square 7)



