;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-220-Tabulate) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 220. 
; 
; Design tabulate, which is the abstraction of the tab-sin and tab-sqrt
; functions given below.
;
; When tabulate is properly designed, use it to define a tabulation function
; for sqr and tan.

; Number -> [List-of Number]
; tabulates sin between n 
; and 0 (inclusive) in a list
(check-expect (tab-sin 0) (list 0))
(check-within (tab-sin 1) (list #i0.8414709848078965 0) 0.1)
(check-within (tab-sin 2) 
              (list #i0.9092974268256817 #i0.8414709848078965 0)
              0.1)

(define (tab-sin n)
  (cond
    [(= n 0) (list (sin 0))]
    [else
     (cons (sin n)
           (tab-sin (sub1 n)))]))

; Number -> [List-of Number]
; tabulates sqrt between n 
; and 0 (inclusive) in a list
(check-expect (tab-sqrt 0) (list 0))
(check-expect (tab-sqrt 1) (list 1 0))
(check-within (tab-sqrt 2) (list #i1.4142135623730951 1 0) 0.1)

(define (tab-sqrt n)
  (cond
    [(= n 0) (list (sqrt 0))]
    [else
     (cons (sqrt n)
           (tab-sqrt (sub1 n)))]))


; Number [Number -> Number] -> [List-of Number]
; tabulate from 0 to n for the given function
(check-expect (tabulate sin 0)  (list 0))
(check-within (tabulate sin 1)  (list #i0.8414709848078965 0) 0.1)
(check-within (tabulate sin 2) 
              (list #i0.9092974268256817 #i0.8414709848078965 0)
              0.1)
(check-expect (tabulate sqrt 0) (list 0))
(check-expect (tabulate sqrt 1) (list 1 0))
(check-within (tabulate sqrt 2)
              (list #i1.4142135623730951 1 0) 
              0.1)

(define (tabulate f n)
  (cond [(= n 0) (list (f 0))]
        [else
         (cons (f n)
               (tabulate f (sub1 n)))]))

; Number -> List-of-numbers
; tabulate sqr between 0 and n inclusive
(check-expect (tabulate-sqr 0) (list 0))
(check-expect (tabulate-sqr 1) (list 1 0))
(check-expect (tabulate-sqr 2) (list 4 1 0))

(define (tabulate-sqr n)
  (tabulate sqr n))

; Number -> List-of-numbers
; tabulate tan between 0 and n inclusive
(check-expect (tabulate-tan 0) (list 0))
(check-within (tabulate-tan 1) (list #i1.5574077246549023 0) 0.1)
(check-within (tabulate-tan 2) 
              (list #i-2.185039863261519 #i1.5574077246549023 0)
              0.1)

(define (tabulate-tan n)
  (tabulate tan n))