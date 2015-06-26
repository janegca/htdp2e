;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-358-cross) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 358.
;
; Design cross. The function consumes a list of symbols and a list of numbers
; and produces all possible ordered pairs of symbols and numbers. That is,
; when given '(a b c) and '(1 2), the expected result is '((a 1) (a 2) (b 1)
; (b 2) (c 1) (c 2)).

; [List-of Symbol] [List-of Number] -> [List-of [List-of Symbol Number]]
; a list of all possible ordered pairs derived from the given Symbol and
; Number lists
(check-expect (cross '() '(1 2))   '())
(check-expect (cross '(a b c) '()) '())
(check-expect (cross '(a) '(1 2))  '((a 1) (a 2)))
(check-expect (cross '(a b c) '(1 2))
              '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)))

(define (cross los lon)
    (cond [(empty? los) '()]
          [else (append (map (lambda (n) (list (first los) n)) lon)
                        (cross (rest los) lon))]))


                        