;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-196-FireFightV2) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 196. 
; 
; Design a fire-fighting game.
;
; The game is set in the western states where fires rage through vast forests.
; It simulates an airborne fire-fighting effort. Specifically, the player acts 
; as the pilot of an airplane that drops loads of water on fires on the ground.
; The player controls the plane’s horizontal movements and the release of water
; loads.
;
; Your game software starts fires randomly anywhere on the ground. You may
; wish to limit the number of fires that may burn at any point in time, making 
; them a function of how many fires are currently burning. The purpose of the
; game is to extinguish all fires with a limited number of water drops.
;
; Use an iterative design approach as illustrated in this chapter to create
; this game.

; In this version:
;
; 6. Add the 'tock' function to 
;    (a) move any dropped water bombs closer to the ground
;        checking if they douse any active fires
;    (b) randomly add a fire to the scene; use length of 
;        dropped bombs to determine when to create them
;        ie 1 fire for every 3 water bombs

; -- Physical Constants
(define WIDTH  200)
(define HEIGHT WIDTH)
(define SPACE (/ WIDTH 10))
(define DELTA (/ SPACE 2))   ; pace at which water bombs drop and plane moves
(define TREE-WIDTH 30)
(define TREE-CENTER (/ TREE-WIDTH 3))
(define TREE-BASE 0)
(define FIRE-FREQ 3)  ; 1:3 ratio of new fires to dropped water bombs

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

; -- Example of graphic elements
(define ex1 (place-image WATER 20 100
             (place-image FIRE 70 180 
                          (place-image PLANE 20 Y-PLANE BGS))))

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
  (render-water (ffw-low w)
                (render-fire (ffw-lof w)
                             (place-image PLANE
                                          (ffw-plane w)
                                          Y-PLANE
                                          BGS))))
            
; Water Image -> Image
; draw the water bombs
(define (render-water low img)
  (cond [(empty? low) img]
        [else (place-image WATER 
                           (posn-x (first low))
                           (posn-y (first low))
                           (render-water (rest low) img))]))
                           
; Fire Image -> Image
; draw the fires
(define (render-fire lof img)
  (cond [(empty? lof) img]
        [else (place-image FIRE
                           (posn-x (first lof))
                           (posn-y (first lof))
                           (render-fire (rest lof) img))]))

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
; is reached, start another plane at the left border
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
; drop a water bomb
(check-expect (drop-water (make-ffw 20 '() '()))
              (make-ffw 20 (list (make-posn 20 (+ Y-PLANE DELTA))) '()))

(define (drop-water w)
  (make-ffw (ffw-plane w)
            (cons (make-posn (ffw-plane w)
                             (+ Y-PLANE DELTA))
                  (ffw-low w))
            (ffw-lof w)))

; FFW -> FFW
; move dropped water bombs and create fires
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
; remove doused fires
(check-expect (douse-fires '() '()) '())
(check-expect (douse-fires (list (make-posn 10 180))
                           (list (make-posn  8 173))) '())
(check-expect (douse-fires (list (make-posn 10 180))
                           (list (make-posn 50 175)
                                 (make-posn  8 170)))
              (list (make-posn 50 175)))

(define (douse-fires low lof)
  (cond [(empty? lof) '()]
        [(is-hit? (first lof) low) (douse-fires low (rest lof))]
        [else (cons (first lof)
                    (douse-fires low (rest lof)))]))

; Posn Water -> Boolean
; returns true if a fire position corresponds to the position of a
; dropped water bomb
(check-expect (is-hit? (make-posn 80 180)
                       (list (make-posn 80 180))) true)
(check-expect (is-hit? (make-posn 80 180) '()) false)
(check-expect (is-hit? (make-posn 80 180)
                       (list (make-posn 20 50)
                             (make-posn 30 110)
                             (make-posn 80 170))) true)

(define (is-hit? f low)
  (cond [(empty? low) false]
        [(close? f (first low)) true]
        [else (is-hit? f (rest low))]))

; Posn Posn -> Boolean
; returns true if the two positions are within range of each other
(define (close? m n)
  (<= (sqrt (+  (sqr (- (posn-x m) (posn-x n))) 
                (sqr (- (posn-y m) (posn-y n)))))
       (image-width FIRE)))

; Water -> Water
; move the current water bombs closer to the ground
(check-expect (move-water-bombs '()) '())
(check-expect (move-water-bombs 
               (list (make-posn 80 100)
                     (make-posn 95 75)))
              (list (make-posn 80 (+ 100 DELTA))
                    (make-posn 95 (+ 75 DELTA))))

(define (move-water-bombs low)
  (cond [(empty? low) '()] 
        [else 
         (cons (make-posn (posn-x (first low))
                               (+ DELTA (posn-y (first low))))
               (move-water-bombs (rest low)))]))

; FFW -> FFW
; add a new fire to the scene
(define (generate-fire w)
  (make-ffw (ffw-plane w)
            (ffw-low   w)
            (cons (make-posn (random WIDTH) 
                   (- HEIGHT (random FIRE-MAX)))
                  (ffw-lof w))))

; -- Main Function ---------------------------------------------------------
; FFW Number -> FFW
; start the application
(define (ffw-main rate)
  (big-bang (make-ffw SPACE '() '())
            [to-draw render-ffw]
            [on-tick tock rate]
            [on-key  control]))

; -- example usage
(ffw-main 0.5)