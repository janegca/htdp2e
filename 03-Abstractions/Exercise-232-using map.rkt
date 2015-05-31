;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Exercise-232-using map|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 232. 
; 
; Use map to define the function convert-euro, which converts a list of US$ 
; amounts into a list of € amounts based on an exchange rate of €1.22 per US$.
;
; Also use map to define convertFC, which converts a list of Fahrenheit
; measurements to a list of Celsius measurements.
;
; Finally, try your hands at translate, a function that translates a list of
; Posns into a list of list of pairs of numbers, 
; i.e., [List-of [list Number Number]].


; [List-of Number] -> [List-of Number]
; convert a list of US$ to a list of Euro's using an exchange
; rate of €1.22 per US$.
(check-expect (convert-euro '()) '())
(check-expect (convert-euro (list 1 2 3 4))
              (list 1.22 (* 2 1.22) (* 3 1.22) (* 4 1.22)))

(define (convert-euro lod)
  (local (; Number -> Number
          (define (rate v)
            (* 1.22 v)))
  (map rate lod)))

; [List-of Number] -> [List-of Number]
; convert a list of Fahrenhiet temperatures to Celsius
(check-expect (convertFC '()) '())
(check-expect (convertFC (list 68 -40 32)) (list 20 -40 0))

(define (convertFC lof)
  (local (; Number -> Number
          (define (ftoc f)
            (* (- f 32) 5/9)))
    (map ftoc lof)))

; [List-of Posn] -> [List-of [list Number Number]]
; translate a list of positions into a list of list of pairs of numbers
(check-expect (translate '()) '())
(check-expect (translate (list (make-posn 10 10)
                               (make-posn 25 5)
                               (make-posn 15 30)))
              (list (list 10 10) (list 25 5) (list 15 30)))

(define (translate lop)
  (local (; Posn -> [List-of Number]
          (define (posn-to-list p)
            (cons (posn-x p) (cons (posn-y p) '()))))
    (map posn-to-list lop)))

