;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 1905-SP-RepresentingShapes) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; 19.05 - Sample Problem - Representing with Lambda

; Sample Problem: 
; 
; Navy strategists represent fleets of ships as rectangles (the ships
; themselves) and circles (their weapons’ reach). The coverage of a fleet of
; ships is the combination of all these shapes. Design a data representation
; for rectangles, circles, and combinations of shapes. Then design a function
; that determines whether some point is within a shape.

; Shape is a function: 
;   [Posn -> Boolean]
; interpretation: if s is a shape and p a Posn, (s p) produces 
; #true if the given Posn is inside of s, #false otherwise

; Number Number -> Shape 
; represents a point at (x,y)
(define (make-point x y)
  (lambda (p)
    (and (= (posn-x p) x) (= (posn-y p) y))))  ; result is a curried function

; Shape Posn -> Boolean
(check-expect (inside? (make-point 3 4) (make-posn 3 4)) #true)
(check-expect (inside? (make-point 3 4) (make-posn 3 -4)) #false)

(define (inside? s p)
  (s p))               ; works because a Shape (s) is a curried fn


; NOTE: the only way we know Shape is a function is because of the 
;       definition we gave up top; can't tell from the signature, Shape
;       might be a structure -- is the 'make-' a clue? the way the function
;       is named? It mimics the way a structure is called i.e. to make
;       a positon we use (make-posn x y). But this would be a convention,
;       not a language (DrRacket/Scheme) requirement.
 
(define a-sample-shape (make-point 3 4))

(equal? (a-sample-shape (make-posn 5 4)) #false)  
(equal? (a-sample-shape (make-posn 3 4)) #true)  

; Number Number Number -> Shape 
; creates a data representation for a circle of radius r
; located at (center-x, center-y) 
(check-expect (inside? (make-circle 3 4 5) (make-posn 0 0)) #true)
(check-expect (inside? (make-circle 3 4 5) (make-posn 0 -1)) #false)
(check-expect (inside? (make-circle 3 4 5) (make-posn -1 3)) #true)

(define (make-circle center-x center-y r)
  ; [Posn -> Boolean]
  (lambda (p)
    (<= (distance-between center-x center-y p) r)))

; -- solved in Exercise 257
; Number Number Posn -> Number
; returns the Cartesian distance between a point at the cooordinates
; x and y and a given position (p)
(check-expect (distance-between 0 0 (make-posn 0 0)) 0)
(check-expect (distance-between 0 0 (make-posn 3 4)) 5)

(define (distance-between x y p)
  (sqrt (+ (sqr (- (posn-x p) x))
           (sqr (- (posn-y p) y)))))


; Number Number Number Number -> Shape
; represent a width by height rectangle whose upper-left
; corner is located at (upper-left-x, upper-left-y)
(check-expect (inside? (make-rectangle 0 0 10 3) (make-posn 0 0))  #true)
(check-expect (inside? (make-rectangle 2 3 10 3) (make-posn 4 5))  #true)
(check-expect (inside? (make-rectangle 0 3 10 3) (make-posn -1 3)) #false)

(define (make-rectangle upper-left-x upper-left-y width height)
  (lambda (p)
    (and (<= upper-left-x (posn-x p) (+ upper-left-x width))
         (<= upper-left-y (posn-y p) (+ upper-left-y height)))))

; NOTE: make-rectangle results in a curried function (Shape)
;       note the way the comparison funtion works
;       (<= v1 v2 ... vM vN) , <= is applied to all values to the left of vN
;       i.e. (and (<= v1 vN)
;                 (<= v2 vN)
;                 ...
;                 (<= vM vN))

; Shape Shape -> Shape
; combines two shapes into one 
; a point inside either shape is inside the combined shape
(define (make-combination s1 s2)
  ; Posn -> Boolean 
  (lambda (p)
    (or (inside? s1 p) (inside? s2 p))))


(define circle1    (make-circle    3 4  5))
(define rectangle1 (make-rectangle 0 3 10 3))
(define union1     (make-combination circle1 rectangle1))
 
(check-expect (inside? union1 (make-posn  0  0)) #true)
(check-expect (inside? union1 (make-posn  0 -1)) #false)
(check-expect (inside? union1 (make-posn -1  3)) #true)


