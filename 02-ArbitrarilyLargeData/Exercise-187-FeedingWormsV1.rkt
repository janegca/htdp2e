;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-187-FeedingWormsV1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 187.
;
; Modify your program from exercise 186 so that it stops if the worm has run 
; into the walls of the world. When the program stops because of this 
; condition, it should render the final scene with the text "worm hit border" 
; in the lower left of the world scene. Hint You can use the stop-when clause 
; in big-bang to render the last world in a special way. Challenge: Show the
; worm in this last scene as if it were on its way out of the box. 

; -- Physical Constants
(define RADIUS   10)
(define DIAMETER (* 2  RADIUS))
(define WIDTH    (* 20 DIAMETER))
(define HEIGHT   (* 20 DIAMETER))

; -- Graphic Constants
(define MT      (empty-scene WIDTH HEIGHT))
(define SEGMENT (circle RADIUS "solid" "red"))
(define MSG     (text "Worm hit border" 16 "black"))

; -- Data Structures
(define-struct worm [x y])
; Worm is a: (make-worm Number Number)
; interpretation: (make-worm x y) the worms position as
; (x,y) coordinates 

; -- Functions
; Worm -> Image
; draw the worm in its current postion
(check-expect (render (make-worm   20 10))
              (place-image SEGMENT 20 10 MT))

(define (render w)
  (place-image SEGMENT (worm-x w) (worm-y w) MT))

; Worm KeyEvent -> Worm
; modifies the positions of the worm based on the given key event
(check-expect (control (make-worm 20 10) "left")
              (make-worm (- 20 DIAMETER) 10))
(check-expect (control (make-worm 20 10) "right")
              (make-worm (+ DIAMETER 20) 10))
(check-expect (control (make-worm 20 10) "up")
              (make-worm 20 (- 10 DIAMETER)))
(check-expect (control (make-worm 20 10) "down")
              (make-worm 20 (+ 10 DIAMETER)))
(check-expect (control (make-worm 20 10) "e")
              (make-worm 20 10))

(define (control w ke)
  (cond [(string=? "up"   ke) (make-worm  (worm-x w)
                                       (- (worm-y w) DIAMETER))]  
        [(string=? "down" ke) (make-worm  (worm-x w)
                                       (+ (worm-y w) DIAMETER))]
        [(string=? "left" ke) (make-worm (- (worm-x w) DIAMETER)
                                       (worm-y w))]
        [(string=? "right" ke) (make-worm (+ (worm-x w) DIAMETER)
                                       (worm-y w))]
        [else w]))

; Worm -> Worm
; with each clock-tick the worm moves one diameter
(check-expect (tock (make-worm 20 10))
              (make-worm (+ DIAMETER 20) (+ DIAMETER 10)))
               
(define (tock w)
  (make-worm (+ DIAMETER (worm-x w))
             (+ DIAMETER (worm-y w))))

; Worm -> Boolean
; returns true if the worm has hit any of the four world edges
(check-expect (game-over? (make-worm 0 20))      true)
(check-expect (game-over? (make-worm 50 50))     false)
(check-expect (game-over? (make-worm 50 HEIGHT)) true)
(check-expect (game-over? (make-worm WIDTH 50))  true)
(check-expect (game-over? (make-worm 50 0))      true)

(define (game-over? w)
  (or (<= (worm-x w) 0)
      (<= (worm-y w) 0)
      (<= WIDTH  (worm-x w))
      (<= HEIGHT (worm-y w))))

; Worm -> Image
; renders the final screen with a message
(check-expect (render-final (make-worm 0 50))
               (place-image MSG 
               (+ 10 (/ (image-width MSG) 2))
               (- HEIGHT (image-height MSG))
               (render (make-worm 0 50))))

(define (render-final w)
    (place-image MSG 
               (+ 10 (/ (image-width MSG) 2))
               (- HEIGHT (image-height MSG))
               (render w)))
  
; Worm -> Worm
; start the worm feeding
(define (worm-main rate)
  (big-bang (make-worm DIAMETER DIAMETER)
            [to-draw   render ]
            [on-key    control]
            [on-tick   tock rate]
            [stop-when game-over? render-final]))

; -- usage example
(worm-main 1)