;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-208-WalkthroughExtract) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 208. 
;
; Check step 1 of the last calculation
;
;    (extract < (cons 6 (cons 4 '())) 5)
;    == (extract < (cons 4 '()) 5)
;
; by hand. Show every step.
;
; Answer:
;
;    (extract < (cons 6 (cons 4 '())) 5)
; == (cond
;       [(empty? (cons 6 (cons 4 '())) 5) '()]
;       [else (cond
;               [(< (first (cons 6(cons 4 '()))) 5)
;                (cons (first (cons 6(cons 4 '())))
;                      (extract < (rest (cons 6(cons 4 '()))) 5))]
;               [else (extract < (rest (cons 6(cons 4 '()))) 5)])])
; == (cond
;       [#false '()]
;       [else (cond
;               [(< (first (cons 6(cons 4 '()))) 5)
;                (cons (first (cons 6(cons 4 '())))
;                      (extract < (rest (cons 6(cons 4 '()))) 5))]
;               [else (extract < (rest (cons 6(cons 4 '()))) 5)])])
; == (cond
;      [(< (first (cons 6(cons 4 '()))) 5)
;           (cons (first (cons 6(cons 4 '())))
;                 (extract < (rest (cons 6(cons 4 '()))) 5))]
;      [else (extract < (rest (cons 6(cons 4 '()))) 5)])])
; == (cond
;      [#false
;           (cons (first (cons 6(cons 4 '())))
;                 (extract < (rest (cons 6(cons 4 '()))) 5))]
;      [else (extract < (rest (cons 6(cons 4 '()))) 5)])])
; == (extract < (rest (cons 6(cons 4 '()))) 5)
; == (extract < (cons 4 '()) 5)


