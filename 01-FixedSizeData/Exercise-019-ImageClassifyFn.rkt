;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-019-ImageClassifyFn) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 19. 
; Define the function image-classify, which consumes an image and produces 
; "tall" if the image is taller than it is wide, "wide" if it is wider than 
; it is tall, or "square" if its width and height are the same. 

(define (image-classify img) 
  (if (= (image-width img) (image-height img)) "square"
      (if (> (image-width img)(image-height img)) "wide" "tall")))

(image-classify (rectangle 10 10 "solid" "red"))  ; square
(image-classify (rectangle 10 20 "solid" "red"))  ; tall
(image-classify (rectangle 20 10 "solid" "red"))  ; wide
