;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-240-RevisitingFireFightv2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 240
;
; NOTE: original exercise is to apply abrstractinons to Full Space Wars
;       (Exercise 195), here, it is being applied to Fire Fighting
;       (Exercise 196).
;
; Inspect the code of your project for places where it can benefit from 
; existing abstraction, e.g., processing lists of shots or charges.
;
; Once you have simplified the code with the use of existing abstractions 
; look for opportunities to create abstractions. Consider moving lists of 
; objects as one example where abstraction may pay off. 

; -- First round of modifications -----------
;  render-water     altered to use a local fn and foldr
;  render-fire      altered to use a local fn and foldr
;  douse-fires      altered to use a local fn and filter
;  is-hit?          altered to use a local fn and ormap
;  move-water-bombs altered to use a local fn and map

; -- Second round of modifications
; render-lobj      consolidated render-water and render-fire into one
;                  function; render-lobj
; is-hit?          removed function, replacing it with local functions
;                  within douse-fires
; in-range?        generalized by turning the tolerance level into a 
;                  parameter

; -- Physical Constants
(define WIDTH  200)
(define HEIGHT WIDTH)
(define SPACE (/ WIDTH 10))
(define DELTA (/ SPACE 2))   ; pace at which water bombs drop and plane moves
(define TREE-WIDTH 30)
(define TREE-CENTER (/ TREE-WIDTH 3))
(define TREE-BASE 0)
(define FIRE-FREQ 3)  ; 1:3 ratio of new fires to dropped water bombs
(define MAX-BOMBS 20) ; maximum number of water bombs to drop
(define FONT-SIZE 24)
(define FONT-COLOR "white")

; -- Graphic Constants

(define PLANE (scale 0.7
                     (rotate 15 
                             (overlay (ellipse 10 20 "solid" "lightgray")
                                      (ellipse 70 10 "solid" "lightgray")))))
  
(define Y-PLANE 30)
  
(define WATER (scale 0.2 (rotate -90 
                      (polygon (list (make-posn 0 0)
                             (make-posn -10 20)
                             (make-posn 60 0)
                             (make-posn -10 -20))
                        "solid" "deepskyblue"))))
(define BOMB-MSG (text "Bombs: " (/ FONT-SIZE 2) FONT-COLOR))

(define FIRE  (overlay (radial-star 5 5 9 "solid" "gold")
                       (radial-star 7 7 20 "solid" "orangered")))

(define PINE  (triangle TREE-WIDTH "solid" "yellowgreen"))
(define TRUNK (rectangle TREE-CENTER (* 2 TREE-CENTER) "solid" "brown"))
(define CONIFER (overlay/xy PINE TREE-BASE TREE-CENTER
                            (overlay/xy PINE TREE-BASE TREE-CENTER 
                                        (overlay/xy PINE 
                                                    TREE-CENTER
                                                    (/ TREE-WIDTH 2)
                                                    TRUNK))))
(define Y-CONIFER (- HEIGHT (/ (image-height CONIFER) 2)))

(define FIRE-MAX (image-height CONIFER))

(define MT (empty-scene WIDTH HEIGHT "darkslategray"))

(define BGS (place-images
             (list CONIFER CONIFER CONIFER CONIFER CONIFER CONIFER)
             (list (make-posn (* 1 SPACE) Y-CONIFER)
                   (make-posn (* 3 SPACE) Y-CONIFER)
                   (make-posn (* 4 SPACE) Y-CONIFER)
                   (make-posn (* 7 SPACE) Y-CONIFER)
                   (make-posn (* 8.5 SPACE) Y-CONIFER)
                   (make-posn (* 9 SPACE) Y-CONIFER))
             MT))

; -- Example of graphic elements (modified to include bomb count)
(define ex1 (place-image WATER 20 100
             (place-image FIRE 70 180 
                          (place-image PLANE 20 Y-PLANE
                                       (place-image 
                                        (beside BOMB-MSG
                                                (text (number->string
                                                       (- MAX-BOMBS 1))
                                                      (/ FONT-SIZE 2)
                                                      FONT-COLOR))
                                        (+ DELTA (/ (image-width BOMB-MSG) 2))
                                        (/ (image-height BOMB-MSG) 2)
                                        BGS)))))

; -- Data Structures
(define-struct ffw [plane low lof])
; FFW is: (make-ffw Number Water Fire)
; interpretation: (make-ffw plane low lof) is a world with a fire fighting
; plane that flies horizontally and drops water bombs (low) to put out 
; fires (lof).
;
; Water is one of:
; '()
; (cons Posn Water)
; interpretation: a list of Posn's for dropped water bombs
;
; Fire is one of:
; '()
; (cons Posn Fire)
; interpretation: a list of Posn's for active fires
; 

; -- Functions

; FFW -> Image
; draws the world in its current state
(check-expect (render-ffw (make-ffw 
                           20 
                           (list (make-posn 20 100)) 
                           (list (make-posn 70 180))))
              ex1)
                           
(define (render-ffw w)
  (render-lobj (ffw-low w)                           ; draw water bombs
                WATER
                (render-lobj (ffw-lof w)             ; draw fires
                             FIRE
                             (place-image PLANE      ; draw plane and msg
                                          (ffw-plane w)
                                          Y-PLANE
                                          (render-bomb-msg w)))))

; FFW -> Image
; adds the bomb count to the background
(define (render-bomb-msg w)
  (place-image 
   (beside BOMB-MSG
           (cond [(>= (- MAX-BOMBS (length (ffw-low w))) 1)
                 (text (number->string (- MAX-BOMBS (length (ffw-low w))))
                 (/ FONT-SIZE 2) FONT-COLOR)]
                 [else (text "0" (/ FONT-SIZE 2) FONT-COLOR)]))
   (+ DELTA (/ (image-width BOMB-MSG) 2))
   (/ (image-height BOMB-MSG) 2)
   BGS))
            
; [List-of Posn] Image Image -> Image
; draw the image (img) at each of the given positions (lpos) on the given
; background image (bg)
(define (render-lobj lpos img bg)
  (local (; Posn Image -> Image
          (define (bld-img p1 prev-posn-img)
            (place-image img (posn-x p1) (posn-y p1) prev-posn-img)))
    (foldr bld-img bg lpos)))
                           
; FFW KeyEvent -> FFW
; responds to user key presses, moving the plane across the scene
; or dropping a water bomb
(check-expect (control (make-ffw 20 '() '()) "right")
              (make-ffw (+ 20 DELTA) '() '()))
(check-expect (control (make-ffw 20 '() '()) " ")
              (make-ffw 20 (list (make-posn 20 (+ Y-PLANE DELTA))) '()))
(check-expect (control (make-ffw 20 '() '()) "e")
              (make-ffw 20 '() '()))

(define (control w ke)
  (cond [(string=? ke "right") (move-right w)]
        [(string=? ke " ")     (drop-water w)]
        [else w]))

; FFW -> FFW
; move the plane to the right, if the border
; is reached, start another plane from the left
(check-expect (move-right (make-ffw 20 '() '()))
              (make-ffw (+ 20 DELTA) '() '()))
(check-expect (move-right (make-ffw (+ 1 WIDTH) '() '()))
              (make-ffw DELTA '() '()))

(define (move-right w)
  (cond [(> (+ (ffw-plane w) DELTA) WIDTH)
         (make-ffw DELTA (ffw-low w) (ffw-lof w))]
        [else (make-ffw (+ (ffw-plane w) DELTA)
                        (ffw-low w)
                        (ffw-lof w))]))
; FFW -> FFW
; drop a new water bomb
(check-expect (drop-water (make-ffw 20 '() '()))
              (make-ffw 20 (list (make-posn 20 (+ Y-PLANE DELTA))) '()))

(define (drop-water w)
  (make-ffw (ffw-plane w)
            (cons (make-posn (ffw-plane w)
                             (+ Y-PLANE DELTA))
                  (ffw-low w))
            (ffw-lof w)))

; FFW -> FFW
; move dropped water bombs and generate fires
(check-random (tock (make-ffw 20 '() '()))
              (make-ffw 20 '() 
                        (list (make-posn (random WIDTH) 
                                         (- HEIGHT (random FIRE-MAX))))))
(check-random (tock (make-ffw 
                     20 
                     (list (make-posn 20 120))
                     '()))
              (make-ffw 20 (list (make-posn 20 120))
                        (list (make-posn (random WIDTH) 
                                         (- HEIGHT (random FIRE-MAX))))))
(check-random (tock (make-ffw 
                     20 
                     (list (make-posn 20 120)
                           (make-posn 70 100)
                           (make-posn 150 90))
                     (list (make-posn 70 180))))
              (make-ffw 20 
                        (list (make-posn 20 120)
                              (make-posn 70 100)
                              (make-posn 150 90))
                        (list (make-posn (random WIDTH) 
                                         (- HEIGHT (random FIRE-MAX)))
                              (make-posn 70 180))))
(check-expect (tock (make-ffw 20
                              (list (make-posn 50 100))
                              (list (make-posn 80 180))))
              (make-ffw 20 
                        (list (make-posn 50 (+ 100 DELTA)))
                        (list (make-posn 80 180))))                         
                        
(define (tock w)
  (cond [(or (empty? (ffw-low w))
             (empty? (ffw-lof w))
             (= 0(modulo (length (ffw-low w)) FIRE-FREQ)))
         (generate-fire w)]
        [else (make-ffw (ffw-plane w)
                        (move-water-bombs (ffw-low w))
                        (douse-fires (ffw-low w) (ffw-lof w)))]))

; Water Fire -> Fire
; return a list of fires that have not been doused
(check-expect (douse-fires '() '()) '())
(check-expect (douse-fires (list (make-posn 10 180))
                           (list (make-posn  8 173))) '())
(check-expect (douse-fires (list (make-posn 10 180))
                           (list (make-posn 50 175)
                                 (make-posn  8 170)))
              (list (make-posn 50 175)))

(define (douse-fires low lof)
  (local (; range for water bomb hit
          (define tolerance (image-width FIRE))
          
          ; Posn -> Boolean
          ; returns true if the fire is not doused by a water bomb
          (define (not-doused f)
           (local ( ; Posn -> Boolean
                   (define (close? w)
                      (in-range? f w tolerance)))
             (not (ormap close? low)))))
    
    (filter not-doused lof)))
  
; Posn Posn Number -> Boolean
; returns true if the two positions are within the given distance
; (tolerance) of each other
(define (in-range? m n tolerance)
  (<= (sqrt (+  (sqr (- (posn-x m) (posn-x n))) 
                (sqr (- (posn-y m) (posn-y n)))))
       tolerance))

; Water -> Water
; move the current water bombs closer to the ground
(check-expect (move-water-bombs '()) '())
(check-expect (move-water-bombs 
               (list (make-posn 80 100)
                     (make-posn 95 75)))
              (list (make-posn 80 (+ 100 DELTA))
                    (make-posn 95 (+ 75 DELTA))))

(define (move-water-bombs low)
  (local (; Posn -> Posn
          ; generates a new position that uses the old x-position and a
          ; changed y-position
          (define (change-posn w)
            (make-posn (posn-x w) (+ DELTA (posn-y w)))))
    (map change-posn low)))

; FFW -> FFW
; add a new fire to the scene
(define (generate-fire w)
  (make-ffw (ffw-plane w)
            (ffw-low   w)
            (cons (make-posn (random WIDTH) 
                   (- HEIGHT (random FIRE-MAX)))
                  (ffw-lof w))))

; FFW -> Boolean
; returns true if the maximum number of water bombs have been dropped
(define (game-over? w)
  (> (length (ffw-low w)) MAX-BOMBS))

; FFW -> Image
; display a game over message
(define (render-final w)
  (overlay (if (empty? (ffw-lof w))
               (text "You Won!"  FONT-SIZE FONT-COLOR)
               (text "You Lost!" FONT-SIZE FONT-COLOR))
           (render-ffw w)))

; -- Main Function ---------------------------------------------------------
; FFW Number -> FFW
; start the application
(define (ffw-main rate)
  (big-bang (make-ffw SPACE '() '())
            [to-draw   render-ffw]
            [on-tick   tock rate]
            [on-key    control]
            [stop-when game-over? render-final]))

; -- example usage
(ffw-main 0.2)
