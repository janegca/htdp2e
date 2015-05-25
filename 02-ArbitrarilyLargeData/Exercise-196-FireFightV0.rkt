;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-196-FireFightV0) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")))))
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

; 1. Design basic graphics: plane, fire, trees, water
; 2. Establish a 'world' structure to hold elements
; 3. Create a 'render' function to draw the world

; -- Physical Constants
(define WIDTH  200)
(define HEIGHT WIDTH)
(define SPACING (/ WIDTH 10))
(define TREE-WIDTH 30)
(define TREE-CENTER (/ TREE-WIDTH 3))
(define TREE-BASE 0)

; -- Graphic Constants

(define PLANE (rotate 15 (overlay (ellipse 10 20 "solid" "lightgray")
                       (ellipse 70 10 "solid" "lightgray"))))
  
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

(define MT (empty-scene WIDTH HEIGHT "darkslategray"))

(define BGS (place-images
             (list CONIFER CONIFER CONIFER CONIFER CONIFER CONIFER)
             (list (make-posn (* 1 SPACING) Y-CONIFER)
                   (make-posn (* 3 SPACING) Y-CONIFER)
                   (make-posn (* 4 SPACING) Y-CONIFER)
                   (make-posn (* 7 SPACING) Y-CONIFER)
                   (make-posn (* 8.5 SPACING) Y-CONIFER)
                   (make-posn (* 9 SPACING) Y-CONIFER))
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
(define (render-ffw w)
  (render-water (ffw-low w)
                (render-fire (ffw-lof w)
                             (place-image PLANE (ffw-plane w) BGS))))
            
; Water Image -> Image
; draws the water bombs
(define (render-water low img)
  (cond [(empty? low) img]
        [else (place-image WATER 
                           (posn-x (first low))
                           (posn-y (first low))
                           (render-water (rest low) img))]))
                           
; Fire Image -> Image
; draws the active forest fires
(define (render-fire lof img)
  (cond [(empty? lof) img]
        [else (place-image FIRE
                           (posn-x (first lof))
                           (posn-y (first lof))
                           (render-fire (rest lof) img))]))