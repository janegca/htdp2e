;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-171-FormulatingTests) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 171. 
;
; Recall from Intermezzo: BSL that BSL comes with several different ways to
; formulate tests. One of them is check-satisfied, which determines whether
; an expression satisfies a certain property.
;
; Use sorted>? from exercise 131 to re-formulate the tests for sort> with
; check-satisfied.
;
; Now consider this function definition: 

;         List-of-numbers -> List-of-numbers
;         produces a sorted version of l
;        (define (sort>/bad l) '(9 8 7 6 5 4 3 2 1 0))

; Can you formulate a test case that shows sort>/bad is not a sorting 
; function? Can you use check-satisfied to formulate this test case?

; Notes (1) What may surprise you here is that we define a function to create
;           a test. In the real world, this step is common and, on occasion,
;           you really need to design functions for tests—with their own tests
;           and all. 
;       (2) Formulating tests with check-satisfied is occasional easier than 
;           using check-expect (or other forms), and it is also a bit more 
;           general. When the predicate complete describes the relationship
;           between all possible inputs and outputs of a function, computer 
;           scientists speak of a specification. Specifying with lambda 
;           explains how to specific sort> completely.


; -- Function from Exercise 131 to use with check-satisfied
;
; NEList-of-temperatures -> Boolean
; returns true if a list of temperatures is sorted in 
; descending order
(check-expect (sorted>? (cons 3(cons 2(cons 1 '())))) true)
(check-expect (sorted>? (cons 1(cons 2(cons 3 '())))) false)

(define (sorted>? nel) 
  (cond
    [(empty? (rest nel)) true]
    [(cons?  (rest nel))
     (cond [(> (first nel) (first (rest nel))) (sorted>? (rest nel))]
           [else false])]))

; -- Sample Problem sort> with re-formulated checks
;
; List-of-numbers -> List-of-numbers 
; rearrange a list of numbers (alon) in descending order 
(check-expect    (sort> '()) '() )  ; sorted>? expects non-empty list
(check-satisfied (sort> (list 12 20 -5)) sorted>?) 
(check-satisfied (sort> (list 3 2 1))    sorted>?)
(check-satisfied (sort> (list 1 2 3))    sorted>?)

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

; -- Test sort>/bad

; List-of-numbers -> List-of-numbers
; produces a sorted version of l
(check-expect    (sort>/bad (list 2 1 3)) (list 3 2 1)) ; fails
(check-satisfied (sort>/bad (list 2 1 3)) sorted>?)     ; passes - need to 
                                                        ; somehow compare
                                                        ; actual results of
                                                        ; the sort

(define (sort>/bad l) 
  '(9 8 7 6 5 4 3 2 1 0))

