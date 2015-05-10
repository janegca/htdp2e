;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-128-ListOfImages) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 128. 
;
; Design ill-sized?. The function consumes a list of images loi and a positive
; number n. It produces the first image on loi that is not an n by n square;
; if it cannot find such an image, it produces #false. 

; List-of-Images PositiveNumber -> Boolean
; returns true if all images in the given list are of size n x n
; returns false if one image is not size n x n
(check-expect (ill-sized? 3 '()) true)
(check-expect (ill-sized? 3 (cons (circle 3 "solid" "red") '())) false)
(check-expect (ill-sized? 4 (cons (rectangle 4 4 "solid" "green") '())) true)
(check-expect (ill-sized? 4 (cons (square 4 "solid" "red")
                                  (cons (square 3 "solid" "red")
                                        (cons (square 4 "solid" "red") '()))))
              false)
(check-expect (ill-sized? 1 (cons (square 1 "solid" "green")
                                 (cons (square 1 "solid" "red")
                                       (cons (square 1 "solid" "blue") '()))))
              true)

(define (ill-sized? n loi)
  (cond
    [(empty? loi) true]
    [(cons? loi)
     (cond [(not (is-nxn? n (first loi))) false]
           [else (ill-sized? n (rest loi))])]))

; Number Image -> Boolean
; returns true if the given image is size n x n, otherwisre, returns false
(define (is-nxn? n img) 
  (and (= n (image-width img)) (= n (image-height img))))
    

