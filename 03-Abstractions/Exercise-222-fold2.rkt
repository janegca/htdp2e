;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-222-fold2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 222. 
; 
; Design fold2, which is the abstraction of the functions product and image*
; given below
;
; Compare this exercise with exercise 221. Even though both involve the 
; product function, this exercise poses an additional challenge because the 
; second function, image*, consumes a list of Posns and produces an Image.
; Still, the solution is within reach of the material in this section, and it
; is especially worth comparing the solution with the one to the preceding 
; exercise. The comparison yields interesting insights into abstract 
; signatures.

; [List-of Number] -> Number
(check-expect (product '()) 1)
(check-expect (product (list 1 2 3)) 6)

(define (product l)
  (cond
    [(empty? l) 1]
    [else
     (* (first l)
        (product (rest l)))]))


; [List-of Posn] -> Image
(check-expect (image* '()) emt)
(check-expect (image* (list (make-posn 10 10) (make-posn 50 50)))
              (place-image dot 10 10
                           (place-image dot 50 50 emt)))
                                        
(define (image* l)
  (cond
    [(empty? l) emt]
    [else
     (place-dot (first l)
                (image* (rest l)))]))

; Posn Image -> Image 
(define (place-dot p img)
  (place-image dot
               (posn-x p) (posn-y p)
               img))

; graphical constants:    
(define emt (empty-scene 100 100))
(define dot (circle 3 "solid" "red"))

; [ITEM -> ITEM] ITEM [List-of ITEM] -> ITEM
; reduces a list using the given function and related null value
(check-expect (fold2 * 1 '()) 1)
(check-expect (fold2 * 1 (list 1 2 3)) 6)
(check-expect (fold2 place-dot emt '()) emt)
(check-expect (fold2 place-dot emt (list (make-posn 10 10)
                                         (make-posn 50 50)))
              (place-image dot 10 10
                           (place-image dot 50 50 emt)))

(define (fold2 f b lst)
  (cond [(empty? lst) b]
        [else (f (first lst) (fold2 f b (rest lst)))]))