;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-149-convertEuro) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 149. 
; 
; Design the function convert-euro, which converts a list of US$ amounts
; into a list of € amounts. Look up the current exchange rate on the web.
;
; Generalize convert-euro to the function convert-euro*, which consumes an 
; exchange rate and a list of US$ amounts and converts the latter into a
; list of € amounts.

; List-of-Dollars -> List-of-Euros
; convert a list of dollars to a list of euros
(check-expect (convert-euro '()) '())
(check-expect (convert-euro (cons 1 '()))
              (cons (* 1 0.88859) '()))
(check-expect (convert-euro (cons 1 (cons 2 '())))
              (cons (* 1 0.88859)(cons (* 2 0.88859) '())))

(define (convert-euro lod)
  (cond [(empty? lod) '()]
        [else (cons (* 0.88859 (first lod)) 
                    (convert-euro (rest lod)))]))

; ExchangeRate List-of-Dollars -> List-of-Euros
; convert a list of US dollars to a list of Euros using the given
; exchange rate
(check-expect (convert-euro* 0.88859 '()) '())
(check-expect (convert-euro* 0.88859 (cons 1 '()))
              (cons (* 1 0.88859) '()))
(check-expect (convert-euro* 0.88859 (cons 1 (cons 2 '())))
              (cons (* 1 0.88859)(cons (* 2 0.88859) '())))

(define (convert-euro* r lod)
  (cond [(empty? lod) '()]
        [else 
         (cons (* r (first lod)) (convert-euro* r (rest lod)))]))
