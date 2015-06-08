;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-255-n-inside-playground) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 255.
; 
; Develop n-inside-playground?, a function that generates a predicate that 
; ensures that the length of the given list is k and that all Posns in this
; list are within a WIDTH by HEIGHT rectangle.
;
; Define random-posns/bad that satisfies n-inside-playground? and does not
; live up to the expectations implied by the above purpose statement. 
; 
; NOTE: This specification is incomplete. Although the word “partial” might
; come to mind, computer scientists reserve the phrase “partial specification”
; for a different purpose. 

(define WIDTH  300)
(define HEIGHT 300)

; Number [List-of Posn] -> Boolean
; is the list of positions equal to n
; are all positions within the list within a width x height rectangle
(define (n-inside-playground? n)
  (local (; Posn -> Boolean
          ; are the position coords within a WIDTH x HEIGHT rectangle
          (define (in-range? pos)
            (local ( (define x (posn-x pos))
                     (define y (posn-y pos)))
              (and (>= x 0) (< x WIDTH)
                   (>= y 0) (< y HEIGHT)))))
  (lambda (lst) 
    (if (and (= n (length lst))
             (andmap in-range? lst))
        #true
        #false))))

; NOTE: for now, must define (name) the curried function if we
;       want to use it in a check-satisfied statement
(define t1 (n-inside-playground? 3))
(define t2 (n-inside-playground? 0))

; N -> [List-of Posn]
; generate n random Posns in a WIDTH by HEIGHT rectangle
(check-satisfied (random-posns 3) t1)
(check-satisfied (random-posns 0) t2)

(define (random-posns n)
  (build-list n (lambda (i) (make-posn (random WIDTH) (random HEIGHT)))))


; -- make a bad position that satifies n-inside-playground?
; the spec says nothing about identical positions within the rectangle
; reasonable assumption is that all positions in the list will be unique

(define (random-posns/bad n)
  (list (make-posn 100 100) (make-posn 100 100)))

(define t3 (n-inside-playground? 2))
(check-satisfied (random-posns/bad 2) t3)
