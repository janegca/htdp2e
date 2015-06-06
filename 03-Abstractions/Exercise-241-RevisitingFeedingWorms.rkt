;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-241-RevisitingFeedingWorms) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 241. 
;
; Feeding Worms explains how another one of the oldest computer games work. 
; The game features a worm that moves at a constant speed in a
; player-controlled direction. When it encounters food, it eats the food and
; grows. When it runs into the wall or into itself, the game is over.
;
; This project can also benefit from the abstract list-processing in ISL. 
; Look for places to use them and replace existing code one piece at a time,
; relying on the tests to ensure the program works. 

; -- Modification
; render        modified to isolate worm and food rendering in
;               local functions and use foldr to draw worm

; -- Physical Constants
(define RADIUS   10)
(define DIAMETER (* 2  RADIUS))
(define WIDTH    (* 20 DIAMETER))
(define HEIGHT   (* 20 DIAMETER))
(define MAX      (- DIAMETER 2))  ; added for food-create function

; -- Graphic Constants
(define MT         (empty-scene WIDTH HEIGHT))
(define SEGMENT    (circle RADIUS "solid" "red"))
(define FOOD       (circle RADIUS "solid" "green"))
(define FONT-SIZE  16)
(define FONT-COLOR "black")
(define MSG        (text "Worm hit wall or self: " FONT-SIZE FONT-COLOR))

; -- Data Structures
(define-struct worm [dir body food])
; A Worm is a strucuture: (make-worm List-of-posns 1String Posn)
; interpretation: (make-worm d b f) where the body (b) is a list
; of segment positions, a direction (d) and the position (f) of a
; piece of worm food.

; A Direction is one of the following 1String's:
; - N (up)
; - S (down)
; - W (left)
; - E (right)

; -- Functions
;
; Worm -> Image
; draw the worm in its current postion
(check-expect (render (make-worm "S" '() (make-posn 100 100))) 
              (place-image FOOD 100 100 MT))
(check-expect (render (make-worm "S" (list (make-posn 10 10)) 
                                 (make-posn 100 100)))
              (place-image SEGMENT 10 10 
                           (place-image FOOD 100 100 MT)))
(check-expect (render (make-worm "S" (list (make-posn 10 10) 
                                           (make-posn 30 10)
                                          (make-posn 30 30))
                                 (make-posn 100 100)))
              (place-image SEGMENT 10 10
                           (place-image SEGMENT 30 10
                                        (place-image SEGMENT 30 30 
                                          (place-image FOOD 100 100 MT)))))

(define (render w)
  (local ( ; Posn -> Image
           (define (render-food f)
             (place-image FOOD (posn-x f) (posn-y f) MT))

           ; [List-of Posn] Image -> Image
           (define (render-worm body bg)
             (local (; Posn Image -> Image
                     (define (bld-worm p prev-pos-img)
                       (place-image SEGMENT 
                                    (posn-x p) (posn-y p) 
                                    prev-pos-img)))
               (foldr bld-worm bg body))))
    
  (render-worm (worm-body w) (render-food (worm-food w)))))


; Worm KeyEvent -> Worm
; changes the direction in which the worm is moving
(check-expect (control (make-worm "S" '() (make-posn 100 100)) "up")
              (make-worm "N" '() (make-posn 100 100)))
(check-expect (control (make-worm "S" '() (make-posn 100 100)) "left")
              (make-worm "E" '() (make-posn 100 100)))
(check-expect (control (make-worm "S" '() (make-posn 100 100)) "right")
              (make-worm "W" '() (make-posn 100 100)))
(check-expect (control (make-worm "S" '() (make-posn 100 100)) "down")
              (make-worm "S" '() (make-posn 100 100)))
(check-expect (control (make-worm "N" '() (make-posn 100 100)) "e")
              (make-worm "N" '() (make-posn 100 100)))

(define (control w ke) 
  (cond [(string=? ke "up")    (make-worm "N" (worm-body w) (worm-food w))]
        [(string=? ke "down")  (make-worm "S" (worm-body w) (worm-food w))]
        [(string=? ke "left")  (make-worm "E" (worm-body w) (worm-food w))]
        [(string=? ke "right") (make-worm "W" (worm-body w) (worm-food w))]
        [else w]))

; Worm -> Worm
; with each clock-tick the worm moves one diameter
; in the current direction
(check-expect (tock (make-worm "N" 
                               (list (make-posn 20 50)) 
                               (make-posn 100 100)))
              (make-worm "N" 
                         (list (make-posn 20 (- 50 DIAMETER)))
                         (make-posn 100 100)))
(check-expect (tock (make-worm "S" 
                               (list (make-posn 20 50))
                               (make-posn 100 100)))
              (make-worm "S" 
                         (list (make-posn 20 (+ 50 DIAMETER)))
                         (make-posn 100 100)))
(check-expect (tock (make-worm "E" 
                               (list (make-posn 50 50))
                               (make-posn 100 100)))
              (make-worm "E" 
                         (list (make-posn (- 50 DIAMETER) 50))
                         (make-posn 100 100)))
(check-expect (tock (make-worm "W" 
                               (list (make-posn 50 50))
                               (make-posn 100 100)))
              (make-worm "W" 
                         (list (make-posn (+ 50 DIAMETER) 50))
                         (make-posn 100 100)))
(check-expect (tock (make-worm "W" 
                               (list (make-posn 50 50)
                                         (make-posn 100 100))
                               (make-posn 100 100)))
              (make-worm "W" 
                         (list (make-posn (+ 50 DIAMETER) 50)
                                   (make-posn 50 50))
                         (make-posn 100 100)))


(define (tock w)
  (cond [(string=? "N"  (worm-dir w)) (move-vert  -1 w)]
        [(string=? "S"  (worm-dir w)) (move-vert   1 w)]
        [(string=? "E"  (worm-dir w)) (move-horiz -1 w)]
        [else (move-horiz 1 w)]))

; Number Worm -> Worm
; create a new worm that has moved either up or down by one diameter
; if the food is eaten during the move the worm gains a new segment
; and a new piece of food is generated
(check-expect (move-vert 1 
                         (make-worm "S" 
                                    (list (make-posn 10 10))
                                    (make-posn 50 50)))
              (make-worm "S" 
                         (list (make-posn 10 (+ 10 DIAMETER)))
                         (make-posn 50 50)))
(check-expect (move-vert -1 
                         (make-worm "N"
                                    (list (make-posn 30 50) (make-posn 50 50))
                                    (make-posn 100 100)))
              (make-worm "N"
                         (list (make-posn 30 30) (make-posn 30 50))
                         (make-posn 100 100))) 
(check-random (move-vert 1 
                         (make-worm "S" 
                                    (list (make-posn 10 10))
                                    (make-posn 10 (+ 10 DIAMETER))))
              (make-worm "S" 
                         (list (make-posn 10 (+ 10 DIAMETER))
                               (make-posn 10 10))
                         (food-create (make-posn 1 1))))
(check-random (move-vert -1 
                         (make-worm "N"
                                    (list (make-posn 30 50) 
                                          (make-posn 50 50))
                                    (make-posn 30 30)))
              (make-worm "N"
                         (list (make-posn 30 (- 50 DIAMETER)) 
                               (make-posn 30 50)
                               (make-posn 50 50))
                         (food-create (make-posn 1 1)))) 

(define (move-vert m w)
  (if (equal? (make-vert-head m (first (worm-body w))) (worm-food w))
      ; don't shrink the worm when it moves and create a new piece of food
      (make-worm (worm-dir w)
                 (cons (make-vert-head m (first (worm-body w)))
                       (worm-body w))
                 (food-create (worm-food w)))
      
      ; shrink the worm when it moves, use the same piece of food
      (make-worm (worm-dir w)
                 (trim-tail (cons (make-vert-head m (first (worm-body w))) 
                                  (worm-body w)))
                 (worm-food w))))

; Number Posn -> Posn
; create a new head for the worm based on the vertical
; direction the worm is moving and the current head position
(define (make-vert-head m h)
  (make-posn (posn-x h)
             (+ (posn-y h) (* m DIAMETER))))

; Number Worm -> Worm
; create a new worm that has moved either left or right by one diameter
; if a piece of food is eaten during the move, the worm gains one segment
(check-expect (move-horiz 1 (make-worm "W" 
                                       (list (make-posn 10 10))
                                       (make-posn 20 20)))
              (make-worm "W" (list (make-posn (+ 10 DIAMETER) 10)) 
                         (make-posn 20 20)))
(check-expect (move-horiz -1
                          (make-worm "E"
                                     (list (make-posn 30 50) 
                                           (make-posn 50 50))
                                     (make-posn 100 100)))
              (make-worm "E"
                         (list (make-posn 10 50)
                               (make-posn 30 50))
                         (make-posn 100 100))) 
(check-random (move-horiz 1 (make-worm "W" 
                                       (list (make-posn 10 10))
                                       (make-posn (+ 10 DIAMETER) 10)))
              (make-worm "W" 
                         (list (make-posn (+ 10 DIAMETER) 10)
                               (make-posn 10 10)) 
                         (food-create (make-posn 1 1))))

(define (move-horiz m w)
  (if (equal? (make-horiz-head m (first (worm-body w))) (worm-food w))
      ; don't shrink the worm when it moves and create a new piece of food
      (make-worm (worm-dir w)
                 (cons (make-horiz-head m (first (worm-body w)))
                       (worm-body w))
                 (food-create (worm-food w)))
      
      ; shrink the worm when it moves, use the same piece of food
      (make-worm (worm-dir w)
                 (trim-tail (cons (make-horiz-head m (first (worm-body w))) 
                                  (worm-body w)))
                 (worm-food w))))

; Number Posn -> Posn
; create a new head for the worm based on the horizontal
; direction the worm is moving and the current head position
(define (make-horiz-head m h)
  (make-posn (+ (posn-x h) (* m DIAMETER))
             (posn-y h)))

; List-of-Posns -> List-of-Posns
; drop the last segment from the worm's body
(check-expect (trim-tail '()) '())
(check-expect (trim-tail (list (make-posn 10 10))) '())
(check-expect (trim-tail (list (make-posn 10 10)
                               (make-posn 30 10)
                               (make-posn 30 30)))
              (list (make-posn 10 10) (make-posn 30 10)))
 
(define (trim-tail tail)
  (cond [(or (empty? tail) 
             (empty? (rest tail))) '()]
        [else (cons (first tail) (trim-tail (rest tail)))]))
          
 
; Worm -> Boolean
; returns true if the worm has hit a wall or turned on itself
(check-expect (game-over? (make-worm "E"
                                     (list (make-posn 10 10)
                                               (make-posn 10 10))
                                     (make-posn 100 100))) true)
(check-expect (game-over? (make-worm "S" 
                                     (list (make-posn 0 20))
                                     (make-posn 100 100))) true)
(check-expect (game-over? (make-worm "S" 
                                     (list (make-posn 50 0))
                                     (make-posn 100 100))) true)
(check-expect (game-over? (make-worm "S" 
                                     (list (make-posn WIDTH 50))
                                     (make-posn 100 100))) true)
(check-expect (game-over? (make-worm "S" 
                                     (list (make-posn 50 HEIGHT))
                                     (make-posn 100 100))) true)
(check-expect (game-over? (make-worm "S" 
                                     (list (make-posn 50 50))
                                     (make-posn 100 100))) false)
                                                      
(define (game-over? w) 
  (cond [(member? (first (worm-body w)) (rest (worm-body w))) true]
        [else (or (<= (posn-x (first (worm-body w))) 0)
                  (<= (posn-y (first (worm-body w))) 0)
                  (<= WIDTH   (posn-x (first (worm-body w))))
                  (<= HEIGHT  (posn-y (first (worm-body w)))))]))

; Worm -> Image
; renders the final screen with a message

(define (render-final w)
    (place-image
               (beside MSG 
                       (text (number->string (length (worm-body w)))
                             FONT-SIZE FONT-COLOR))
               (+ 10 (/ (image-width MSG) 2))
               (- HEIGHT (image-height MSG))
               (render w)))
                              

; -- Provided functions with defintions and check-expects added ---
;
; Posn -> Posn 
; generates a random position for the placement of the worm food
(check-satisfied (food-create (make-posn 1 1)) not-equal-1-1?)
 
(define (food-create p)
  ; [NOTE: modified originally provided code to create grid-like placements
  ;        of food; ensuring worm segments will fully overlap food pieces.
  ;        If location vs physical coords were used then the adjustment
  ;        would have been needed in the rendering functions.]
  (food-check-create p (make-posn (- (* DIAMETER (random MAX)) RADIUS)
                                  (- (* DIAMETER (random MAX)) RADIUS))))

; Posn Posn -> Posn 
; generative recursion 
; compares two positions, returning a new random position if they are
; equal (i.e. if the two positions coincide, a new position is created)
(check-random (food-check-create (make-posn 50 50) (make-posn 50 50))
              (food-create (make-posn 1 1)))
(check-expect (food-check-create (make-posn 1 1) (make-posn 50 50))
              (make-posn 50 50))

(define (food-check-create p candidate)
  (if (equal? p candidate) (food-create p) candidate))
 
; Posn -> Boolean
; use for testing only 
(check-expect (not-equal-1-1? (make-posn 1 1)) false)
(check-expect (not-equal-1-1? (make-posn 2 2)) true)

(define (not-equal-1-1? p)
  (not (and (= (posn-x p) 1) (= (posn-y p) 1))))

; -- Main Function
; Worm Number -> Worm
; start the worm feeding
(define (worm-main rate)
  (big-bang (make-worm "S" 
                       (list (make-posn 10 10)) 
                       (food-create (make-posn 1 1)))
            [to-draw   render ]
            [on-key    control]
            [on-tick   tock rate]
            [stop-when game-over? render-final]))

; -- usage example
(worm-main 0.5)
