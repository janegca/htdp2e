;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-188-FeedingWormsV2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 188. 
;
; Develop a data representation for worms with tails. A worm’s tail is a 
; possibly empty sequence of “connected” segments. Here “connected” means 
; that the coordinates of a segment differ from those of its predecessor in
; at most one direction and, if rendered, the two segments touch. To keep 
; things simple, treat all segments—head and tail segments—the same.
;
; Then modify your program from exercise 186 to accommodate a multi-segment
; worm. Keep things simple: 
;
; (1) your program may render all worm segments as red disks
; (2) one way to think of the worm’s movement is to add a segment in the
;     direction in which it is moving and to delete the last segment; and 
; (3) ignore that the worm may run into the wall or into itself.


; -- Physical Constants
(define RADIUS   10)
(define DIAMETER (* 2  RADIUS))
(define WIDTH    (* 20 DIAMETER))
(define HEIGHT   (* 20 DIAMETER))

; -- Graphic Constants
(define MT (empty-scene WIDTH HEIGHT))
(define SEGMENT (circle RADIUS "solid" "red"))

; -- Data Structures
(define-struct worm [dir body])
; A Worm is a strucuture: (make-worm List-of-posns 1String)
; interpretation: (make-worm b d) where the body (b) is a list
; of segment positions and a direction

; A Dir is one of the following 1String's:
; - N (up)
; - S (down)
; - W (left)
; - E (right)

; -- Functions
; Worm -> Image
; draw the worm in its current postion
(check-expect (render (make-worm "S" '())) MT)
(check-expect (render (make-worm "S" (list (make-posn 10 10))))
              (place-image SEGMENT 10 10 MT))
(check-expect (render (make-worm "S" (list (make-posn 10 10) 
                            (make-posn 30 10)
                            (make-posn 30 30))))
              (place-image SEGMENT 10 10
                           (place-image SEGMENT 30 10
                                        (place-image SEGMENT 30 30 MT))))

(define (render w) 
  (cond [(empty? (worm-body w)) MT]
        [else (place-image SEGMENT
                           (posn-x (first (worm-body w)))
                           (posn-y (first (worm-body w)))
                           (render (make-worm (worm-dir w) 
                                              (rest (worm-body w)))))]))
                              
; Worm KeyEvent -> Worm
; changes the direction in which the worm is moving
(check-expect (control (make-worm "S" '()) "up")
              (make-worm "N" '()))
(check-expect (control (make-worm "S" '()) "left")
              (make-worm "E" '()))
(check-expect (control (make-worm "S" '()) "right")
              (make-worm "W" '()))
(check-expect (control (make-worm "S" '()) "down")
              (make-worm "S" '()))
(check-expect (control (make-worm "N" '()) "e")
              (make-worm "N" '()))

(define (control w ke) 
  (cond [(string=? ke "up")    (make-worm "N" (worm-body w))]
        [(string=? ke "down")  (make-worm "S" (worm-body w))]
        [(string=? ke "left")  (make-worm "E" (worm-body w))]
        [(string=? ke "right") (make-worm "W" (worm-body w))]
        [else w]))

; Worm -> Worm
; with each clock-tick the worm moves the worm one diameter
; in the current direction
(check-expect (tock (make-worm "N" (list (make-posn 20 50))))
              (make-worm "N" (list (make-posn 20 (- 50 DIAMETER)))))
(check-expect (tock (make-worm "S" (list (make-posn 20 50))))
              (make-worm "S" (list (make-posn 20 (+ 50 DIAMETER)))))
(check-expect (tock (make-worm "E" (list (make-posn 50 50))))
              (make-worm "E" (list (make-posn (- 50 DIAMETER) 50))))
(check-expect (tock (make-worm "W" (list (make-posn 50 50))))
              (make-worm "W" (list (make-posn (+ 50 DIAMETER) 50))))
(check-expect (tock (make-worm "W" (list (make-posn 50 50)
                                         (make-posn 100 100))))
              (make-worm "W" (list (make-posn (+ 50 DIAMETER) 50)
                                   (make-posn 50 50))))

(define (tock w)
  (cond [(string=? "N" (worm-dir w))
         (make-worm "N" (move-vert -1 (worm-body w)))]
        [(string=? "S" (worm-dir w))
         (make-worm "S" (move-vert 1 (worm-body w)))]
        [(string=? "E" (worm-dir w))
         (make-worm "E" (move-horiz -1 (worm-body w)))]
        [else (make-worm "W" (move-horiz 1 (worm-body w)))]))
  

; Number List-of-Posns -> List-of-Posns
; moves the worm vertically (up if the multiplier is negative, right if
; positive) by the space of one Diameter
(check-expect (move-vert 1 (list (make-posn 10 10)))
              (list (make-posn 10 (+ 10 DIAMETER))))
(check-expect (move-vert -1 (list (make-posn 30 50) (make-posn 50 50)))
              (list (make-posn 30 30) (make-posn 30 50))) 
              
(define (move-vert m t)
  (trim-tail (cons (make-posn (posn-x (first t))
                              (+ (posn-y (first t)) (* m DIAMETER)))
                   t)))

; Number List-of-Posns -> List-of-Posns
; moves the worm horizontally (left if multiplier is negative,  right
; if positive) by the space of one Diameter
(check-expect (move-horiz 1 (list (make-posn 10 10)))
              (list (make-posn (+ 10 DIAMETER) 10)))
(check-expect (move-horiz -1 (list (make-posn 30 50) (make-posn 50 50)))
              (list (make-posn 10 50) (make-posn 30 50))) 

(define (move-horiz m t)
  (trim-tail (cons (make-posn (+ (posn-x (first t)) (* m DIAMETER))
                              (posn-y (first t))) t)))
         
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
        [else (cons (first tail) 
                    (trim-tail (rest tail)))]))
 
; Worm -> Worm
; start the worm feeding
(define (worm-main rate)
  (big-bang (make-worm "S"
                       (list (make-posn DIAMETER DIAMETER)
                             (make-posn 40 20)
                             (make-posn 60 20)))            
            [to-draw render ]
            [on-key  control]
            [on-tick tock rate]))

; -- usage example
(worm-main 0.2)