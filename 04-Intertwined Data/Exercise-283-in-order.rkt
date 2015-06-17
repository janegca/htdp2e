;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-283-in-order) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 283. 
; Design the function inorder. It consumes a binary tree and produces the 
; sequence of all the ssn numbers in the tree as they show up from left to 
; right when looking at a tree drawing.
;
; Hint Use append, which concatenates lists like thus:
;
;    (append (list 1 2 3) (list 4) (list 5 6 7))
;    ==
;    (list 1 2 3 4 5 6 7)
;
; What does inorder produce for a binary search tree? 

(define-struct no-info ())
(define NONE (make-no-info))
 
(define-struct node (ssn name left right))
; A BinaryTree (short: BT) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

; -- Example BT's

(define n1 (make-node 87 'a NONE NONE))
(define n2 (make-node 24 'b NONE NONE))
(define n3 (make-node 33 'c NONE NONE))
(define n4 (make-node 99 'd NONE NONE))

(define n5 (make-node 15 'c n1 n2))
(define n6 (make-node 95 'd NONE n4))
(define n7 (make-node 29 'e n5 NONE))
(define n8 (make-node 89 'f n3 n6))
(define n9 (make-node 63 'g n7 n8))

; BT -> [List-of Number]
; the sequence of ssn's in a binary tree as they appear left to right
(check-expect (inorder n1) (list 87))
(check-expect (inorder n5) (list 87 15 24))
(check-expect (inorder n6) (list 95 99))
(check-expect (inorder n7) (list 87 15 24 29))

(define (inorder t)
  (cond [(eq? NONE t) '()]
        [else (append (inorder (node-left t))
                      (list (node-ssn t))
                      (inorder (node-right t)))]))



