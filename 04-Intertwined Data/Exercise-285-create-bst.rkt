;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-285-create-bst) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 285. 
; 
; Design the function create-bst. It consumes a BST B, a number N, and a 
; symbol S. It produces a BST that is just like B and that in place of one
; NONE subtree contains the node structure
;
;    (make-node N S NONE NONE)
;
; Once you have completed the design, create tree A from figure 73 using
; create-bst.

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

; BST Number Symbol -> BST
; a BST with the node Number Symbol inserted in correct tree sort order
(check-expect (create-bst NONE 10 'a) n1)
(check-expect (create-bst n5 29 'f) 
              (make-node 15 'e n1 (make-node 24 'b NONE
                                             (make-node 29 'f NONE NONE))))
(check-expect (create-bst (make-node 89 
                                     'h 
                                     NONE
                                     (make-node 95 'g NONE NONE))
                          77 'c)
              (make-node 89 
                         'h 
                         (make-node 77 'c NONE NONE)
                         (make-node 95 'g NONE NONE)))
(check-expect (create-bst n6 29 'f) n6)

(define (create-bst t n s)
  (cond [(eq? NONE t) (make-node n s NONE NONE)]
        [(< n (node-ssn t))
         (make-node (node-ssn t)
                    (node-name t)
                    (create-bst (node-left t) n s)
                    (node-right t))]
        [(> n (node-ssn t)) 
         (make-node (node-ssn t)
                    (node-name t)
                    (node-left t)
                    (create-bst (node-right t) n s)) ]
        [else t]))

; -- build tree A
(define crown (create-bst NONE 63 'i))
(define b1 (create-bst crown 29 'f))
(define r1 (create-bst b1 89 'h))
(define b2 (create-bst r1 15 'e))
(define r2 (create-bst b2 95 'g))
(define b3 (create-bst r2 10 'a))
(define b4 (create-bst b3 24 'b))
(define r3 (create-bst b4 77 'c))
(define r4 (create-bst r3 99 'd))  ; final tree



