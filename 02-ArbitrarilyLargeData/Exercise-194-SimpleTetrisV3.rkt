;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-194-SimpleTetrisV3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 194. 
; 
; Equip the program from exercise 193 with a stop-when clause. The game ends 
; when one of the columns contains HEIGHT blocks.
;
; It turns out that the design of the stop-when handler is complex. So here 
; are hints: 
;
; (1) Design a function that consumes a natural number i and creates a column 
;     of i blocks. Use the function to define a Landscape for which the game 
;     should stop. 

; (2) Design a function that consumes a Landscape and a natural number x0. The
;     function should produce the list of blocks that have the x coordinate x0.

; (3) Finally, design a function that determines whether the length of any 
;     column in some given Landscape is HEIGHT.
;
; Once you have solved exercise 194 you have a bare-bones Tetris game. You may
; wish to polish it a bit before you show it to your friends. For example, the
; final screen could show a text that says how many blocks the player was able 
; to stack up. Or every screen could contain such a text. The choice is yours.

; [NOTES: possible modifications
;         add a function to determine if a row is full
;         add a function to remove a full row and drop remaining blocks
;          so they fill the emptied space
;         add a function to randomly select a new block's colour

; -- Physical Constants
(define WIDTH  10)    ; the maximum number of blocks horizontally 
(define HEIGHT 15)    ; the maximum number of blocks vertically
 
; -- Graphical Constants 
(define SIZE 10)              ; blocks are square 
(define HALF-SIZE (/ SIZE 2)) ; block center coord
(define BLOCK                 ; blocks are red squares with black rims
  (overlay (rectangle (- SIZE 1) (- SIZE 1) "solid" "red")
           (rectangle SIZE SIZE "outline" "black")))
 
; need the scene in pixels (physical coords)
(define SCENE-SIZE   (* WIDTH  SIZE)) 
(define SCENE-HEIGHT (* HEIGHT SIZE))
(define MT (empty-scene SCENE-SIZE SCENE-HEIGHT))

(define FONT-SIZE 12)
(define FONT-COLOR "black")
(define MSG (text "Game-over: "
                  FONT-SIZE FONT-COLOR))

; -- Data Structures
(define-struct tetris [block landscape])
; A Tetris is (make-tetris Block Landscape)
; A Landscape is one of: 
; – '() 
; – (cons Block Landscape)

(define-struct block [x y])
; Block is (make-block N N)
 
; interpretation: given (make-tetris (make-block x y) (list b1 b2 ...))
; (x,y) is the logical position of the dropping block, while
; b1, b2, etc are the positions of the resting blocks 
; A logical position (x,y) determines how many SIZEs the block is
; the left (x) and top (y) borders.

; Tetris -> Image
; draw the current Tetris world
(check-expect (tetris-render (make-tetris (make-block 0 0) '()))
              (overlay/align "left" "top" BLOCK MT))

(define (tetris-render t)
  (render-block (tetris-block t)
                (render-landscape (tetris-landscape t))))
  
; World -> Image
; draw a series of blocks using their location info
(check-expect (render-landscape '()) MT)
(check-expect (render-landscape (list (make-block 0 0)))
              (overlay/align "left" "top" BLOCK MT))

(define (render-landscape lst)
  (cond [(empty? lst) MT]
        [else (render-block (first lst)
                            (render-landscape (rest lst)))]))

; Block Image -> Image
; draw a block, placeing it on the given image
(check-expect (render-block (make-block 0 0) MT)
              (overlay/align "left" "top" BLOCK MT))
(check-expect (render-block (make-block 4 4) MT)
              (place-image BLOCK (+ (* 4 SIZE) HALF-SIZE)
                                 (+ (* 4 SIZE) HALF-SIZE) MT))
(check-expect (render-block (make-block 9 9) MT)
              (place-image BLOCK (+ (* 9 SIZE) HALF-SIZE)
                                 (+ (* 9 SIZE) HALF-SIZE) MT))

(define (render-block b img)
  ; match the row and column widths to the Block size
  ; (x,y) are the block's center coords
  (place-image BLOCK
               (+ (* SIZE (block-x b)) HALF-SIZE)
               (+ (* SIZE (block-y b)) HALF-SIZE)
               img))

; Tetris -> Tetris
; moves the dropping block down one row on every clock tick
(check-expect (tock (make-tetris (make-block 0 0) '()))
              (make-tetris (make-block 0 1) '()))
(check-random (tock (make-tetris (make-block 0 (- HEIGHT 1)) '()))
              (make-tetris (make-block (random WIDTH) 0)
                           (list (make-block 0 (- HEIGHT 1)))))

(define (tock t)
  (cond [(landed? t) 
         ; add dropping block to landscape and generate new block
         (block-generate (make-tetris (tetris-block t) 
                                      (cons (tetris-block t)
                                            (tetris-landscape t))))]
        ; continue dropping current non-landscape block
        [else (make-tetris (make-block (block-x (tetris-block t))
                                       (+ 1 (block-y (tetris-block t))))
                           (tetris-landscape t))]))

; Tetris -> Boolean
; return true if the dropping block has landed on the floor or
; atop another block
(check-expect (landed? (make-tetris
                                 (make-block 1 (- HEIGHT 1)) '())) true)
(check-expect (landed? (make-tetris (make-block 5 2)
                                    (list (make-block 0 (- HEIGHT 1))
                                          (make-block 5 (- HEIGHT 1))
                                          (make-block 5 (- HEIGHT 1)))))
              false)
(check-expect (landed? (make-tetris (make-block 5 5)
                                    (list (make-block 5 6))))
                       true)
(check-expect (landed? (make-tetris (make-block 5 1)
                                    (list (make-block 5 4))))
              false)

(define (landed? t)
  (or (= (- HEIGHT 1) (block-y (tetris-block t)))
      (member? (make-block (block-x (tetris-block t))
                       (+ 1 (block-y (tetris-block t))))
               (tetris-landscape t))))

; Tetris -> Tetris
; create a new block in a randomly chosen column
(check-random (block-generate (make-tetris (make-block 3 (- HEIGHT 1))
                                           (list 
                                            (make-block 3 (- HEIGHT 1))
                                            (make-block 4 (- HEIGHT 1)))))
              (make-tetris (make-block (random WIDTH) 0)
                           (list (make-block 3 (- HEIGHT 1))
                                 (make-block 4 (- HEIGHT 1)))))

(define (block-generate t)
  (block-check-generate (make-block (random WIDTH) 0) t))

; Block Tetris -> Tetris
; if the generated block is already part of the landscape, try again
; otherwise, return a world with the newly generated block
(define (block-check-generate b t)
  (if (member? b (tetris-landscape t)) 
      (block-generate t)
      (make-tetris b (tetris-landscape t))))

; Tetris KeyEvent -> Tetris
; move the dropping block left or right, if possible
(check-expect (control (make-tetris (make-block 1 3) '()) "left")
              (make-tetris (make-block 0 3) '()))
(check-expect (control (make-tetris (make-block (- WIDTH 1) 7) '()) "right")
              (make-tetris (make-block (- WIDTH 1) 7) '()))
(check-expect (control (make-tetris (make-block 0 3) '()) "e")
              (make-tetris (make-block 0 3) '()))
              
(define (control t ke)
  (cond [(string=? "left"  ke) (move-left t)]
        [(string=? "right" ke) (move-right t)]
        [else t]))

; Tetris -> Tetris
; moves the dropping block one column to the left, 
; if possible
(check-expect (move-left (make-tetris (make-block 1 5) '()))
              (make-tetris (make-block 0 5) '()))
(check-expect (move-left (make-tetris (make-block 1 8)
                                      (list (make-block 0 8)
                                            (make-block 0 9))))
              (make-tetris (make-block 1 8)
                           (list (make-block 0 8)
                                 (make-block 0 9))))
(check-expect (move-left (make-tetris (make-block 0 5) '()))
              (make-tetris (make-block 0 5) '()))
 
(define (move-left t) 
  (cond [(= 0 (block-x (tetris-block t))) t]
        [(member? (make-block (- (block-x (tetris-block t)) 1)
                              (block-y (tetris-block t)))
                  (tetris-landscape t)) t]
        [else (make-tetris (make-block (- (block-x (tetris-block t)) 1)
                                       (block-y (tetris-block t)))
                           (tetris-landscape t))]))
                                     

; Tetris -> Tetris
; moves the dropping block one column to the right,
; if possible
(check-expect (move-right (make-tetris (make-block 6 3) '()))
              (make-tetris (make-block 7 3) '()))
(check-expect (move-right (make-tetris (make-block (- WIDTH 1) 7) '()))
              (make-tetris (make-block (- WIDTH 1) 7) '()))
(check-expect (move-right (make-tetris (make-block 5 7) 
                                       (list (make-block 6 7))))
              (make-tetris (make-block 5 7)
                           (list (make-block 6 7))))

(define (move-right t) 
  (cond [(= (- WIDTH 1) (block-x (tetris-block t))) t]
        [(member? (make-block (+ (block-x (tetris-block t)) 1)
                              (block-y (tetris-block t)))
                  (tetris-landscape t)) t]
        [else (make-tetris (make-block (+ (block-x (tetris-block t)) 1)
                                       (block-y (tetris-block t)))
                           (tetris-landscape t))]))

; -- Functions for Exercise 194

; Number -> List-of-blocks
; creates a list of blocks forming one column of height n
(check-expect (create-column 0) '())
(check-expect (create-column 1) (list (make-block 0 0)))
(check-expect (create-column 4)
              (list (make-block 0 3) 
                    (make-block 0 2) 
                    (make-block 0 1) 
                    (make-block 0 0)))

(define (create-column n)
  (cond [(= 0 n) '()]
        [else (cons (make-block 0 (- n 1))
                    (create-column (- n 1)))]))

; -- Example Landscape using the create-column function (Hint 1)
(define lnd0 (create-column HEIGHT))

; Landscape Number -> List-of-blocks
; return a list of all blocks located a (x,0)
(check-expect (get-top-of-column '() 3) '())
(check-expect (get-top-of-column (list (make-block 1 0)) 1)
              (list (make-block 1 0)))
(check-expect (get-top-of-column (list (make-block 3 2)
                                       (make-block 4 0)
                                       (make-block 7 1)) 4)
              (list (make-block 4 0)))

(define (get-top-of-column lst n) 
  (cond [(empty? lst) '()]
        [ (and (= n (block-x (first lst)))
               (= 0 (block-y (first lst))))
          (list (first lst))]
        [else (get-top-of-column (rest lst) n)]))
                
; Tetris -> Boolean
; return true if any column length equals HEIGHT
(check-expect (game-over? (make-tetris (make-block 10 3)
                                 (create-column HEIGHT)))
              true)
              
(define (game-over? t) 
  (check-columns WIDTH (tetris-landscape t)))

; Number Landscape -> Boolean
; return true if one of the columns in the landscape is full
(check-expect (check-columns WIDTH '()) false)
(check-expect (check-columns WIDTH (create-column 4)) false)
(check-expect (check-columns WIDTH (create-column HEIGHT)) true)

(define (check-columns n lst)
  (cond [(= 0 n) false]
        [(= HEIGHT (length (get-column (- n 1) lst)))
         true]
        [else (check-columns (- n 1) lst)]))
      
; Number Landscape -> List-of-blocks
(check-expect (get-column 0 (create-column HEIGHT))
              (create-column HEIGHT))
  
(define (get-column n lst)
  (cond [(empty? lst) '()]
        [(= n (block-x (first lst)))
         (cons (first lst) (get-column n (rest lst)))]
        [else (get-column n (rest lst))]))

; Tetris -> Image
; renders the final screen with a message
;(check-expect (render-final (make-tetris (make-block 5 5))
;                            (create-column HEIGHT)))

(define (render-final t)
    (place-image
               (beside MSG 
                       (text (number->string 
                              (+ 1 (length (tetris-landscape t))))
                             FONT-SIZE FONT-COLOR))
               (+ 10 (/ (image-width MSG) 2))
               (- SCENE-HEIGHT (/ (image-height MSG) 2))
               (tetris-render t)))

; Tetris Number -> Tetris
; main routine
(define (tetris-main rate)
  (big-bang (make-tetris (make-block 0 0) '())
            [to-draw   tetris-render]
            [on-key    control]            
            [on-tick   tock rate]
            [stop-when game-over? render-final]))

; -- usage example
(tetris-main 0.2)
