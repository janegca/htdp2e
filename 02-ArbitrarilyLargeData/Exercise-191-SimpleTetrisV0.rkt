;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-191-SimpleTetrisV0) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 191. 
;
; When you are presented with a complex data definition—like the one for the 
; state of a Tetris game—you start by creating instances of the various data 
; collections. Here are some suggestive names for examples you can later use 
; for functional examples:
;
;    (define landscape0 ...)
;    (define block-dropping ...)
;    (define tetris0 ...)
;    (define tetris0-drop ...)
;    ...
;    (define block-landed (make-block 0 (- HEIGHT 1)))
;    ...
;    (define block-on-block (make-block 0 (- HEIGHT 2)))
;
; Design the program tetris-render, which turns a given instance of Tetris 
; into an Image. Use DrRacket’s interaction area to develop the expression
; that renders some of your (extremely) simple data examples. Then formulate 
; the functional examples as unit tests and the function itself.

; -- Physical Constants
(define WIDTH  10)    ; the maximum number of blocks horizontally 
(define HEIGHT 15)    ; the maximum number of blocks vertically
 
; -- Graphical Constants 
(define SIZE 10)              ; blocks are square 
(define HALF-SIZE (/ SIZE 2)) ; needed for centering blocks
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
; draw a block
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
  ; (x,y) coords are the ones the block is centered on
  (place-image BLOCK
               (+ (* SIZE (block-x b)) HALF-SIZE)
               (+ (* SIZE (block-y b)) HALF-SIZE)
               img))

; -- Example block collections
(define block-landed   (make-block 0 (- HEIGHT 1)))
(define block-on-block (make-block 0 (- HEIGHT 2)))
(define landscape0 (list block-landed block-on-block))

; need to create a block off-screen to create an 'empty' tetris world
(define tetris0 (make-tetris (make-block -10 -10) '()))

(define block-dropping (make-block 2 (- HEIGHT 8)))
(define tetris0-drop (make-tetris block-dropping '()))

(define tetris1 (make-tetris block-dropping landscape0))

; -- usage examples
(tetris-render tetris0)
(tetris-render tetris0-drop)
(tetris-render tetris1)