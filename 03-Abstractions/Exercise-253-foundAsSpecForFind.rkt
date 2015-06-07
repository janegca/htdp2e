;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-253-foundAsSpecForFind) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 253. 
; 
; Develop found?, a specification for the find function.
; Use found? to formulate a check-satisfied test for find.

; Notes:
;  - X must be in the original list if anything other than false is returned
;      use member? to test
;  - the values succedent to the found X must be in the original list
;    and the must come after X in the original list
;      how to test for this?? find the location of X and then check that
;      the location of all the elements in the returned list are found
;      in locations greater than X in the original?
;      or split the original list at X and see if it matches the rest
;         of the returned result

; X [List-of X] -> [Maybe [List-of X]]
; produces the first sublist of l that starts with x, #false otherwise
(check-expect (find "a" '()) #false)
(check-expect (find "a" (list "b" "c" "a" "d" "e"))
              (list "a" "d" "e"))
(check-expect (find "abc" (list "def" "ghi" "abc" "xyz"))
              (list "abc" "xyz"))

(define (find x l)
  (cond
    [(empty? l) #false]
    [else (if (equal? (first l) x) l (find x (rest l)))]))


