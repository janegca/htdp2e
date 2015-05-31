;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 1805-Example-DesigningWithAbstractions) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 18.05 - Example - Designin with Abstractions

; 1. Follow the first 3 steps of the design recipe for functions
;    i.e. distill the problem into:
;        (1) a signature
;        (2) a problem statement and example, and
;        (3) a stub definition
;
;    For example, consider the problem of defining a function that places
;    small red circles on a 200 by 200 canvas for a given list of Posns. 
;    The first three steps design recipe yield this much: 

; [List-of Posn] -> Image 
; adds the Posns on lop to the empty scene 
 
(check-expect (dots (list (make-posn 12 31)))
              (place-image DOT 12 31 BACKGROUND))
 
(define (dots.v0 lop)
  BACKGROUND)
 
(define BACKGROUND (empty-scene 200 200))
(define DOT (circle 5 "solid" "red"))

; 2. Use the signature to find a matching higher order function (abstraction)
;    i.e. an existing function that handles a generalized from of the problem
;         we are trying to solve.
;
;    For example,  foldr and foldl both have similar signatures to our
;    'dots' ... they both take a list and return a single value
;
;           foldr : [X Y -> Y] Y [List-of X] -> Y
;           foldl : [X Y -> Y] Y [List-of X] -> Y
;
;    We will need to supply a helper function and an base value along
;    with our list of positions (here, X would be our positions and
;    Y, our images.
; 
; 3. Write down a template which makes use of the higher order function
;    and, in this case, the helper function
;    For our example problem,
;        (define (dots lop)
;          (local (; Posn Image -> Image 
;             (define (add-one-dot p scene) ...))
;          (foldr add-one-dot BACKGROUND lop)))
;
;    We chose 'foldr' but could also have used 'foldl'.
;
; 4. Define the helper function.
;    For our example,

(define (dots lop)
  (local (; Posn Image -> Image 
          ; adds a DOT at p to scene
          (define (add-one-dot p scene)
            (place-image DOT (posn-x p) (posn-y p) scene)))
    (foldr add-one-dot BACKGROUND lop)))

; 5. Test the definition in the usual manner.

