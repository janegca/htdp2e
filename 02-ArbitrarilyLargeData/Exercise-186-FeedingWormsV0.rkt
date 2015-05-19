;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-186-FeedingWormsV0) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 186. 
; 
; Design an interactive GUI program that continually moves a one-segment worm
; and enables a player to control the movement of the worm with the four 
; cardinal arrow keys. Your program should use a red disk to render the 
; one-and-only segment of the worm. For each clock tick, the worm should move
; a diameter.
;
; Hints 
; (1) Re-read section Designing World Programs to recall how to design world 
;     programs. When you define the worm-main function, use the rate at which
;     the clock ticks as its argument. See the documentation for on-tick on 
;     how to describe the rate. 
;
; (2) When you develop a data representation for the worm, contemplate the 
;     use of two different kinds of representations: a physical representation 
;     and a logical one. The physical representation keeps track of the actual
;     physical position of the worm on the screen; the logical one counts how
;     many (widths of) segments the worm is from the left and the top. For 
;     which of the two is it easier to change the physical appearances 
;     (size of worm segment, size of game box) of the “game?” 

; -- Physical Constants
(define RADIUS   10)
(define DIAMETER (* 2  RADIUS))
(define WIDTH    (* 20 DIAMETER))
(define HEIGHT   (* 20 DIAMETER))

; -- Graphic Constants
(define MT (empty-scene WIDTH HEIGHT))
(define SEGMENT (circle RADIUS "solid" "red"))

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
              (make-worm 20 (+ DIAMETER 10)))
(check-expect (control (make-worm 20 10) "down")
              (make-worm 20 (- 10 DIAMETER)))
(check-expect (control (make-worm 20 10) "e")
              (make-worm 20 10))

(define (control w ke)
  (cond [(string=? "up"   ke) (make-worm  (worm-x w)
                                       (+ DIAMETER (worm-y w)))]  
        [(string=? "down" ke) (make-worm  (worm-x w)
                                       (- (worm-y w) DIAMETER))]
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

; Worm -> Worm
; start the worm feeding
(define (worm-main rate)
  (big-bang (make-worm 10 10)
            [to-draw render ]
            [on-key  control]
            [on-tick tock rate]))

; -- usage example
(worm-main 1)