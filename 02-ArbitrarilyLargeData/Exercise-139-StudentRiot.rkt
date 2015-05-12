;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-139-StudentRiot) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 139. 
;
; Design a program that visualizes a 1968-style European student riot. 
; A small group of students meets to make paint-filled balloons, enters some 
; lecture hall and randomly throws the balloons at the attendees.
;
; The program’s only input should be a natural number, which represents the 
; number of balloons. The program should produce an image that contains a
; black grid, which represents the seats, and the positions of the balls.
;
; You may wish to re-use the functions from exercise 138.
;
; [Note: see Exercise 145 for a revision of 'student-riot' that positions
;        the balloons in the center of the seat squares]

; -- Functions from Exercise 138
;
; N Image -> Image
; create a column (vertical arrangement) of n images
(check-expect (col 3 (square 10 "outline" "black"))
              (above (square 10 "outline" "black")
                     (square 10 "outline" "black")
                     (square 10 "outline" "black")))

(define (col n img)
  (cond
    [(zero? n) (empty-scene 0 0)]
    [(positive? n) (above img (col (sub1 n) img))]))

; N Image -> Image
; create a row (horizontal arrangement) of n images
(check-expect (row 3 (square 10 "outline" "black"))
              (beside (square 10 "outline" "black")
                      (square 10 "outline" "black")
                      (square 10 "outline" "black")))

(define (row n img)
  (cond
    [(zero? n) (empty-scene 0 0)]
    [(positive? n) (beside img (row (sub1 n) img))]))

; N N -> Image
; create an n x n grid of 10 x 10 empty squares
(check-expect (grid 2 2)
              (above (row 2 (square 10 "outline" "black"))
                     (row 2 (square 10 "outline" "black"))))

(define (grid c r)
  (cond
    [(zero? r) (empty-scene 0 0)]
    [(positive? r)
     (above (row c (square 10 "outline" "black"))
            (grid c (sub1 r) ))]))

; -- Start of Exercise 139 ------------------------------------------------
;
; -- Physical Constants
(define ROWS 18)
(define COLS  8)

; -- Graphic Constant
(define BALLOON (circle 5 "solid" "red"))
(define SEATS   (grid COLS ROWS))         ; grid seats in a lecture hall

; NaturalNumber -> Image
; displays a grid with n randomly tossed balloons
(check-random (student-riot 7)
              (place-image BALLOON
                  (* 10 (random COLS))
                  (* 10 (random ROWS))
                  (student-riot (sub1 7))))

(define (student-riot n)
  (cond
    [(zero? n) SEATS]
    [(positive? n)
     (place-image BALLOON
                  (* 10 (random COLS))
                  (* 10 (random ROWS))
                  (student-riot (sub1 n)))]))

; usage example
(student-riot 15)
