;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-145-StudentRiotRev) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 145. 
; 
; Turn the exercise of exercise 139 into a world program. Its main function 
; should consume the rate at which to display the balloon throwing:
;    ; Number -> ShotWorld 
;    ; displays the student riot at rate ticks per second
;    (define (main rate)
;      (big-bang '()
;                (on-tick drop-balloon rate)
;                (stop-when long-enough)
;                (to-draw to-image)))
;
; Naturally, the riot should stop when the students are out of balloons.
;
; [Note: Modified the constants and student-riot of Exercise 139 to get
;        rid of the 'magic numbers' for seat size and to center the balloons
;        in the seat squares.]

; -- Grid Functions from Exercise 138
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

; -- Start of Exercise 139  (modified) ---------------------------------------
;
; -- Physical Constants
(define ROWS 18)
(define COLS  8)
(define RADIUS 5)            ; radius of balloon
(define SEAT (* 2 RADIUS))   ; size of square for a seat
(define NUM-OF-BALLOONS 20)

; -- Graphic Constant
(define BALLOON (circle RADIUS "solid" "red"))
(define SEATS   (grid COLS ROWS))         ; grid seats in a lecture hall

; NaturalNumber -> Image
; displays a grid with n randomly tossed balloons
; [Note: not called, left here for reference]
(check-random (student-riot 7)
              (place-image BALLOON
                  (- (* SEAT (random COLS)) RADIUS)
                  (- (* SEAT (random ROWS)) RADIUS)
                  (student-riot (sub1 7))))

(define (student-riot n)
  (cond
    [(zero? n) SEATS]
    [(positive? n)
     (place-image BALLOON
                  (- (* SEAT (random COLS)) RADIUS)
                  (- (* SEAT (random ROWS)) RADIUS)
                  (student-riot (sub1 n)))]))

; -- Start of Exercise 145 ------------------------------
;
; A StudentRiotWorld is a list of DroppedBalloon positions
;
; A DroppedBallon is an (x,y) Posn representing a seat location
;
; [Note: the 'student-riot' function from Exercise 139 has
;        been split into the 'dropped-balloons' and 'to-image' functions]
;
; Number -> StudentRiotWorld 
; displays the dropped balloons at the given ticks-rate per second
(define (main rate)
      (big-bang '()
                (on-tick   drop-balloons rate)
                (stop-when long-enough)
                (to-draw   to-image)))

; StudentRiotWorld -> Image
; draw the world using the list of dropped balloon positions
(define (to-image w)
  (cond
    [(empty? w) SEATS]
    [else (place-image BALLOON
                       (posn-x (first w))
                       (posn-y (first w))
                       (to-image (rest w)))]))

; StudentRiotWorld -> Boolean
; end the program when the maximum number of balloons 
; have been dropped
(define (long-enough w) 
  (> (length w) NUM-OF-BALLOONS))

; StudentRiotWorld -> StudentRiotWorld
; generate a list of positions representing the seat locations
; of the dropped balloons
(define (drop-balloons w) 
  (cons (make-posn (- (* SEAT (random COLS)) RADIUS)
                   (- (* SEAT (random ROWS)) RADIUS)) w))
  
; usage example
(main 0.1)



                