;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-148-convertFC) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 148. 
; 
; Design convertFC. The function converts a list of Fahrenheit temperatures 
; to a list of Celsius measurements.

; List-of-Numbers -> List-of-Numbers
; converts a list of Fahrenheit temperatures to a 
; list of temperaturs in Celsius
(check-expect (convertFC* '()) '())
(check-expect (convertFC* (cons 32 '())) 
              (cons 0 '()))
(check-expect (convertFC* (cons 32 (cons -40 '())))
              (cons 0 (cons -40 '())))

(define (convertFC* lof)
  (cond [(empty? lof) '()]
        [else (cons (ftoc (first lof)) 
                    (convertFC* (rest lof)))]))

; Number -> Number
; convert a temperature given in Fahrenheit to Celsius
(check-expect (ftoc 68) 20)
(check-expect (ftoc -40) -40)

(define (ftoc f)
  (* (- f 32) 5/9))
