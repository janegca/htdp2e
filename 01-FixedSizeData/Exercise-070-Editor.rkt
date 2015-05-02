;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-070-Editor) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 70. 
; Design the function render, which consumes an Editor and produces an image.
; The purpose of the function is to render the text within an empty scene of 
; 200 x 20 pixels. For the cursor, use a 1 x 20 red rectangle and for the 
; strings, black text of size 16.
;
;Develop the image for a sample string in DrRacket’s interaction area. 
;We started with this expression:
;
;    (overlay/align "left" "center"
;                   (text "hello world" 11 'black)
;                   (empty-scene 200 20))
;
; You may wish to read up on beside, above, and such functions. When you are
; happy with the looks of the image, use the expression as a test and as a 
; guide to the design of render. 

(define-struct editor [pre post])
; Editor = (make-editor String String)
; interpretation (make-editor s t) means the text in the editor is
; (string-append s t) with the cursor displayed between s and t

; Pyhsical constants
(define WIDTH      200)
(define HEIGHT      20)
(define YCENTER (/ HEIGHT 2))
(define FONT-SIZE   16)
(define FONT-COLOR "black")

; Graphic constants
(define FIELD  (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))

; Editor -> Image
; returns the editor text as an image
(check-expect (render (make-editor "hello " "world"))
              (overlay/align "left" "center"
                             (beside (text "hello " FONT-SIZE FONT-COLOR)
                                     CURSOR
                                     (text "world" FONT-SIZE FONT-COLOR))
                             FIELD))
              
(define (render e) 
  (place-image/align 
   (beside (text (editor-pre e) FONT-SIZE FONT-COLOR)
           CURSOR
           (text (editor-post e) FONT-SIZE FONT-COLOR))
   0 YCENTER "left" "center" FIELD))
