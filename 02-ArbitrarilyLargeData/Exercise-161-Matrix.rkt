;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-161-Matrix) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 161. 
; Mathematics teachers may have introduced you to matrix calculations by now.
; Numeric programs deal with those, too. Here is one possible data 
; representation for matrices: 

; A Matrix is one of: 
;  – '()
;  – (cons Row Matrix) 

; An Row is one of: 
;  – '() 
;  – (cons Number Row) 
; interpretation a matrix is a list of rows, a row is a list of numbers
; constraint all rows are of the same length

; Study it and translate the two-by-two matrix consisting of the numbers 
; 11, 12, 21, 22 into this data representation:
;        11 12
;        21 22
;
; Here is the solution for the five-second puzzle:

    (define row1 (cons 11 (cons 12 '())))
    (define row2 (cons 21 (cons 22 '())))
    (define mat1 (cons row1 (cons row2 '())))
;
; The following function implements the important mathematical operation of 
; transposing the entries in a matrix. To transpose means to mirror the 
; entries along the diagonal, that is, the line from the top-left to the 
; bottom-right. Again, stop! Transpose mat1 by hand, then read on: 
;         11 21
;         12 22
;

; Matrix -> Matrix
; transpose the items on the given matrix along the diagonal  
(define wor1 (cons 11 (cons 21 '())))
(define wor2 (cons 12 (cons 22 '())))
(define tam1 (cons wor1 (cons wor2 '()))) 
(check-expect (transpose mat1) tam1) 

(define (transpose lln)
  (cond    [(empty?    (first lln)) '()]   
           [else (cons (first* lln) (transpose (rest* lln)))]))

; The definition assumes two auxiliary functions:
;
;    first*, which consumes a matrix and produces the first column as a 
;            list of numbers;
;
;    rest*, which consumes a matrix and removes the first column. 
;           The result is a matrix.
;
; Even though you lack definitions for these functions, you should be able to
; understand how transpose works. You should also understand that you cannot 
; design this function with the design recipes you have seen so far. 
; Explain why.
;
; Design the two “wish list” functions. Then complete the design of the 
; transpose with some test cases.

; Matrix -> List-of-Numbers
; returns the first column of the given matrix as a list of numbers
(check-expect (first* mat1) (cons 11 (cons 21 '())))

(define (first* m) 
  (cond [(empty? m) '()]
        [else (cons (first (first m)) (first* (rest m)))]))

; Matrix -> Matrix
; returns the given matrix with the first column removed
(check-expect (rest* mat1) (cons 
                            (cons 12 '()) 
                            (cons (cons 22 '()) 
                                  '())))

(define (rest* m) 
  (cond [(empty? m) '()]
        [else (cons (rest (first m)) (rest* (rest m)))]))








