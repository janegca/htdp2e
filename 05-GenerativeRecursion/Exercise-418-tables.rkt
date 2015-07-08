;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-418-tables) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 418.
;
; A table is a structure of two fields: the natural number VL and a function
; array, which consumes natural numbers and, for those between 0 and VL
; (exclusive), produces answers.
;
; Since this data structure is somewhat unusual, it is critical to illustrate
; it with examples. [Here] table1’s array function is defined for more inputs
; than its length field allows; table2 is defined for just one input, namely 0.
; Finally, we also define a useful function (table-ref) for looking up values
; in tables.
;
; The root of a table t is the number in (table-array t) that is closest to 0.
; A root index is a natural number i such that (table-ref t i) is a root of
; table t.
;
; A table t is monotonically increasing if (table-ref t 0) is less then
; (table-ref t 1), (table-ref t 1) is less than (table-ref t 2), and so on.
;
; Design find-linear. The function consumes a monotonically increasing table
; and finds the smallest index for a root of the table. Use the structural
; recipe for N, proceeding from 0 through 1, 2, and so on to the array-length
; of the given table. This kind of root-finding process is often called a
; linear search.
;
;


(define-struct table [length array])
; A Table is a 
;   (make-table N [N -> Number])

; -- Table examples
(define table1 (make-table 3 (lambda (i) i)))
 
; N -> Number
(define (a2 i)
  (if (= i 0) pi (error "table2 is not defined for i =!= 0")))
 
(define table2 (make-table 1 a2))

; Table N -> Number
; looks up the ith value in array of t
(define (table-ref t i)
  ((table-array t) i))

; Table -> Number
; find the smallest index for the root a table
(define (find-linear t)
  (local ((define VL (- (table-length t) 1))

          (define (find-root i)
            (local ((define val (table-ref t i))
                    (define other-values (find-root (+ i 1))))  
            (cond
              [(= i VL)  i]  ; end of table
              [(= 0 val) i]  ; first zero value
              [else (if (<= val other-values) i other-values)]))))
    (find-root 0)))

; re-write - have to start at the end of the table otherwise (+ i 1) is
; non-terminating



    
          
         

