;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 1903-Examples-ReplacingLocalDefnsWithLambdas) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; 19.03 - Examples - Replacing Locals with Lambdas

; original example of placing a dot on a image using
; foldr and a local function

(define BACKGROUND (empty-scene 100 100))
(define DOT (circle 3 "solid" "red"))

(define (dots-local lop)
  (local (; Posn Image -> Image 
          ; adds a DOT at p to scene
          (define (add-one-dot p scene)
            (place-image DOT (posn-x p) (posn-y p) scene)))
    (foldr add-one-dot BACKGROUND lop)))

; becomes, when a lambda replaces a local function,
(define (dots-lambda lop)
   (foldr (lambda (one-posn scene)
             (place-image DOT (posn-x one-posn) (posn-y one-posn) scene))
          BACKGROUND lop))

(check-expect (dots-local (list (make-posn 10 10)))
              (dots-lambda (list (make-posn 10 10))))


; [List-of Posn] -> [List-of Posn]
; add 3 to every x-position
(define (add-3-to-all.local lop)
  (local (; Posn -> Posn
          ; adds 3 to the x coordinate of the given Posn
          (define (add-3-to-one p)
            (make-posn (+ (posn-x p) 3)
                       (posn-y p))))
    (map add-3-to-one 
         lop)))

(define (add-3-to-all.lambda lop)
   (map (lambda (p) (make-posn (+ (posn-x p) 3) 
                               (posn-y p)))       ; replaces add-3-to-one
        lop))

(check-expect (add-3-to-all.local (list (make-posn 30 10)
                                        (make-posn  0  0)))
              (add-3-to-all.lambda (list (make-posn 30 10) 
                                         (make-posn 0 0))))


; [List-of Posn] -> [List-of Posn]
; eliminate any positions whose the y-position is greater than 100
(define (keep-good.local lop)
  (local (; Posn -> Posn
          ; should this Posn stay on the list
          (define (good? p)
            (<= (posn-y p) 100)))
    (filter good? lop)))
 
(define (keep-good.lambda lop)
   (filter (lambda (p) (<= (posn-y p) 100)) ; replaces good?
           lop))

(check-expect (keep-good.local (list (make-posn 0 110) 
                                     (make-posn 0 60)))
              (keep-good.lambda (list (make-posn 0 110)
                                      (make-posn 0 60))))

; -- defintions/functions used by next example

(define CLOSENESS 5)

; Posn Posn Number -> Boolean
; returns true if the two positions are within the given distance
; (tolerance) of each other
(define (close-to m n tolerance)
  (<= (sqrt (+  (sqr (- (posn-x m) (posn-x n))) 
                (sqr (- (posn-y m) (posn-y n)))))
       tolerance))

; [List-of Posn] -> Boolean
(define (close?.local lop pt)
  (local (; Posn -> Boolean
          ; is one shot close to pt
          (define (is-one-close? p)
            (close-to p pt CLOSENESS)))
    (ormap is-one-close? 
           lop)))
 
(define (close?.lambda lop pt)
   (ormap (lambda (p) (close-to p pt CLOSENESS)) ; replaces is-one-close?
          lop))

(check-expect (close?.local (list (make-posn 10 10)) (make-posn 12 11))
              (close?.lambda (list (make-posn 10 10)) (make-posn 12 11)))