;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname SP-EnumerateFn) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Sample Problem: 
; Design enumerate. The function consumes a list and produces a list of the 
; same items paired with their relative index.

; here's the solution using buld-list

(check-expect (enumerate '(a b c)) '((1 a) (2 b) (3 c)))

(define (enumerate lst)
  (build-list (length lst)
              (lambda (i) 
                (list (+ i 1) (list-ref lst i)))))

; this is the solution using for/list (available in Racket but not yet
; available in DrRacket v 6.1.1 HtDP2e teachpacks)

; [List-of X] -> [List-of [List N X]]
; pair each item in l with its index 
;(check-expect (enumerate.loop '(a b c)) '((1 a) (2 b) (3 c)))

;(define (enumerate.loop l)
;  (for/list ((item l) (ith (length l)))
;    (list (+ ith 1) item)))



                             