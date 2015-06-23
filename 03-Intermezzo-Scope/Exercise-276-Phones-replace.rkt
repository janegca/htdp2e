;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-276-Phones-replace) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 276.
;
; Use match to design the function replace, which substitutes the area code
; 713 with 281 in a list of phone records. For a structure type definition of
; phone records, see above. Formulate a suitable data definition first. If you
; are stuck, look up your solution for exercise 155.

(require 2htdp/abstraction)

(define-struct phone [area switch four])
; A Phone is a structure: 
;   (make-phone Three Three Four)
; A Three is between 100 and 999. 
; A Four is between 1000 and 9999.

; List-of-Phones -> List-of-Phones
; replaces all occurrences of area code 713 with 281.
(check-expect (replace '()) '())
(check-expect (replace (cons (make-phone 713 999 9999) '()))
              (cons (make-phone 281 999 9999) '()))
(check-expect (replace (cons (make-phone 713 999 9999)
                             (cons (make-phone 713 555 55555) '())))
              (cons (make-phone 281 999 9999)
                    (cons (make-phone 281 555 55555) '())))
(check-expect (replace (cons (make-phone 999 999 9999) '()))
              (cons (make-phone 999 999 9999) '()))
(check-expect (replace (cons (make-phone 999 999 9999)
                             (cons (make-phone 713 555 5555) '())))
              (cons (make-phone 999 999 9999)
                    (cons (make-phone 281 555 5555) '())))

(define (replace lop)
  (match lop
    ['() '()]
    [(cons (phone 713 switch four) tail)
     (cons (make-phone 281 switch four) (replace tail))]
    [(cons head tail) (cons head (replace tail))]))

