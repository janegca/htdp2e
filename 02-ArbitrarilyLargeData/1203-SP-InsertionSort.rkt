;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 1203-SP-InsertionSort) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; 12.03 - Sample Problem - Insertion Sort
;
; Design a function that sorts a list of (real) numbers.

; List-of-numbers -> List-of-numbers 
; rearrange a list of numbers (alon) in descending order 
(check-expect (sort> '()) '()) 
(check-expect (sort> (list 12 20 -5)) (list 20 12 -5)) 
(check-expect (sort> (list 3 2 1)) (list 3 2 1))
(check-expect (sort> (list 1 2 3)) (list 3 2 1))

(define (sort> alon) 
  (cond    [(empty? alon) '()]  
           [else (insert (first alon) (sort> (rest alon)))]))

; Number List-of-numbers -> List-of-numbers
; inserts n into the sorted list of numbers (alon)
(check-expect (insert 5 '()) (list 5))
(check-expect (insert 5 (list 6)) (list 6 5))
(check-expect (insert 5 (list 4)) (list 5 4))
(check-expect (insert 12 (list 20 -5)) (list 20 12 -5))
(check-expect (insert 4 (list 3 2 1)) (list 4 3 2 1))
(check-expect (insert 1 (list 3 2)) (list 3 2 1))

(define (insert n alon) 
  (cond    [(empty? alon) (cons n '())]   
           [else (if (>= n (first alon))    
                     (cons n alon)         
                     (cons (first alon) (insert n (rest alon))))]))




