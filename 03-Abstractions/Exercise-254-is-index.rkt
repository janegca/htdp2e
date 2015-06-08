;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-254-is-index) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 254. 
; 
; Develop is-index?, a specification for the index function.
; Use is-index? to formulate a check-satisfied test for index.


; X [List-of X] -> [Maybe N]
; determine the (0-based) index of the first occurrence of x in l, 
; #false otherwise
(check-expect (index "a" '()) #false)
(check-expect (index "a" '("b" "c" "a")) 2)

(define (index x l)
  (cond
    [(empty? l) #false]
    [else (if (equal? (first l) x)
              0
              (local ((define i (index x (rest l))))
                (if (boolean? i) i (+ i 1))))]))

; X [Maybe N] [List-of X] -> Boolean
; is x in lst and n is between 0 and (length lst)
; is x not in lst and n is #false
(check-expect ((is-index? "a" '())            #false) #true)
(check-expect ((is-index? "a" '("b" "c" "a")) 2)      #true)
(check-expect ((is-index? "a" '("a" "b" "c")) 0)      #true)
(check-expect ((is-index? "a" '("b")) 1)              #false)
(check-expect ((is-index? "a" '("a" "b" "c")) 3)      #false)

(define (is-index? x lst)
  (lambda (n)
    (if (or  (and (member? x lst)
                  (>= n 0)
                  (<  n (length lst)))
             (and (not (member? x lst))
                  (equal? n #false)))
        #true
        #false)))
  
; -- check-satisfied tests
;
; NOTE  2015-06-08:
;       as per Matthias Felleisen, a new release of DrRacket is expected
;       shortly after which it will not be necessary to define (name) curried
;       functions before using them in check-satisfied statements

(define t1 (is-index? "a" '()))
(define t2 (is-index? "a" '("b" "c" "a")))

(check-satisfied (index "a" '())            t1)
(check-satisfied (index "a" '("b" "c" "a")) t2)


  