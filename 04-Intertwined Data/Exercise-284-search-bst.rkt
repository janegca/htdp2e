;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-284-search-bst) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 284. 
; 
; Design search-bst. The function consumes a number n and a BST. If the tree 
; contains a node whose ssn field is n, the function produces the value of 
; the name field in that node. Otherwise, the function produces NONE. The 
; function organization must exploit the BST Invariant so that the function
; performs as few comparisons as necessary.
;
; Compare searching in binary search trees with searching in sorted lists 
; from exercise 174. 

(define-struct no-info ())
(define NONE (make-no-info))
 
(define-struct node (ssn name left right))
; A BinaryTree (short: BT) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

; -- Example BST's

(define n1 (make-node 10 'a NONE NONE))
(define n2 (make-node 24 'b NONE NONE))
(define n3 (make-node 77 'c NONE NONE))
(define n4 (make-node 99 'd NONE NONE))

(define n5 (make-node 15 'e n1 n2))
(define n6 (make-node 29 'f n5 NONE))
(define n7 (make-node 95 'g NONE n4))
(define n8 (make-node 89 'h n3 n7))
(define n9 (make-node 63 'i n6 n8))

; Number BST -> [Maybe Symbol]
; the name associated with the ssn in the binary search tree, if found
; otherwise, false
(check-expect (search-bst 10 n1) 'a)
(check-expect (search-bst 15 n6) 'e)
(check-expect (search-bst 89 n9) 'h)
(check-expect (search-bst 11 n9) #false)

(define (search-bst n t)
  (cond [(eq? NONE t) #false]
        [(= n (node-ssn t)) (node-name t)]
        [(< n (node-ssn t)) (search-bst n (node-left t))]
        [else (search-bst n (node-right t))]))