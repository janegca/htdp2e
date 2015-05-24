;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-193-SimpleTetrisV2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 193.
;
; Modify the program from exercise 192 so that a player can control the left 
; or right movement of the dropping block. Each time the player presses the 
; "left" arrow key, the dropping block should shift one column to the left 
; unless it is in column 0 or there is already a stack of resting blocks to
; its left. Similarly, each time the player presses the "right" arrow key, 
; the dropping block should move one column to the right if possible.

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


; Tetris Number -> Tetris
; main routine
(define (tetris-main rate)
  (big-bang (make-tetris (make-block 0 0) '())
            [to-draw   tetris-render]
            [on-key    control]
            [on-tick   tock rate]))

; -- usage example
(tetris-main 0.2)
