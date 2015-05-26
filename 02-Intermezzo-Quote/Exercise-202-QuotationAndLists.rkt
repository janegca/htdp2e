;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-202-QuotationAndLists) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 202. 
;
; Eliminate quote from the following expressions so that they use list instead:

;    '(1 "a" 2 #false 3 "c")

;    '()

;    and this table-like shape:
;
;        '(("alan" 1000)
;          ("barb" 2000)
;          ("carl" 1500)
;          ("dawn" 2300))
;
; Now eliminate list in favor of cons where needed.

(define ex1 '(1 "a" 2 #false 3 "c"))
(define ex1a (list 1 "a" 2 false 3 "c"))
(define ex1b (cons 1(cons "a"(cons 2(cons #false(cons 3(cons "c" '())))))))

(define ex2  '())
(define ex2a '())
(define ex2b '())

(define ex3 '(("alan" 1000)
              ("barb" 2000)
              ("carl" 1500)
              ("dawn" 2300)))
(define ex3a (list (list "alan" 1000)
                   (list "barb" 2000)
                   (list "carl" 1500)
                   (list "dawn" 2300)))

(define ex3b (cons (cons "alan"(cons 1000 '()))
                   (cons (cons "barb"(cons 2000 '()))
                         (cons (cons "carl"(cons 1500 '()))
                               (cons (cons "dawn"(cons 2300 '())) 
                                     '())))))
; -- check-expecst to test values

(check-expect ex1 ex1a)
(check-expect ex1 ex1b)

(check-expect ex2 ex2a)
(check-expect ex2 ex2b)

(check-expect ex3 ex3a)
(check-expect ex3 ex3b)