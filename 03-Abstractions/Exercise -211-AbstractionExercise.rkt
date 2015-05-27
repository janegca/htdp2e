;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |Exercise -211-AbstractionExercise|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 211.
; 
; Abstract the functions inf and sup (given below) into a single function.
; Both consume non-empty lists of numbers (Nelon) and produce a single number. 
; The left one produces the smallest number in the list, the right one the 
; largest.
;
; Define inf-1 and sup-1 in terms of the abstract function. Test each of them
; with these two lists: 
;
; (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1)
; 
; (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25)
; 
; Why are these functions slow on some of the long lists?

; Modify the original functions with the use of max, which picks the larger of
; two numbers, and min, which picks the smaller one. Then abstract again, 
; define inf-2 and sup-2, and test them with the same inputs again. Why are 
; these versions so much faster?

; For a complete answer to the two questions on performance, see Local 
; Function Definitions. 

(define t1
  (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))

(define t2 
  (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25))

; Nelon -> Number
; determines the smallest 
; number on l

;(check-expect (inf t1) 1)    ; takes way too long
(check-expect (inf t2) 1)

(define (inf l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (cond
       [(< (first l) (inf (rest l)))
        (first l)]
       [else
        (inf (rest l))])]))
		
; Nelon -> Number
; determines the largest 
; number on l
(check-expect (sup t1) 25)
;(check-expect (sup t2) 25)   ; takes way to long

(define (sup l)
  (cond
    [(empty? (rest l))
     (first l)]
    [else
     (cond
       [(> (first l) (sup (rest l)))
        (first l)]
       [else
        (sup (rest l))])]))


; Relation Lon -> Number
; return the single number that best satisfies the given relation
(check-expect (reduce < t2) (inf t2))
(check-expect (reduce > t1) (sup t1))

(define (reduce R lon)
  (cond [(empty? (rest lon)) (first lon)]
        [else (cond [(R (first lon) 
                        (reduce R (rest lon)))
                     (first lon)]
                    [else (reduce R (rest lon))])]))

; -- Original inf and sup revised to use min and max functions

; Nelon -> Number
; determines the smallest 
; number on l
(check-expect (inf.v2 t2) 1)
(check-expect (inf.v2 t1) 1)

(define (inf.v2 l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (min (first l) (inf.v2 (rest l)))]))
    
		
; Nelon -> Number
; determines the largest 
; number on l
(check-expect (sup.v2 t1) 25)
(check-expect (sup.v2 t2) 25)

(define (sup.v2 l)
  (cond
    [(empty? (rest l)) (first l)]
    [else (max (first l) (sup.v2 (rest l)))]))
    
; Nelon -> Number
; return the single number that best satsifies the relation
(check-expect (reduce.v2 min t1) 1)
(check-expect (reduce.v2 min t2) 1)
(check-expect (reduce.v2 max t1) 25)
(check-expect (reduce.v2 max t2) 25)

(define (reduce.v2 R lon)
  (cond [(empty? (rest lon)) (first lon)]
        [else (R (first lon) (reduce.v2 R (rest lon)))]))
