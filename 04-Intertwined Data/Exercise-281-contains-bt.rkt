;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-281-contains-bt) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 281. 
;
; Draw the above two trees in the manner of figure 73. Then design 
; contains-bt?, which determines whether a given number occurs in some given
; BT. 

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

; Number BT -> Boolean
; #true if the number is found in the tree
(check-expect (contains-bt?  87 n1) #true)
(check-expect (contains-bt?  99 n6) #true)
(check-expect (contains-bt?  89 n9) #true)
(check-expect (contains-bt?  10 n9) #false)

(define (contains-bt? n t)
  (cond [(eq? NONE t)       #false]
        [(= n (node-ssn t)) #true]
        [else (or (contains-bt? n (node-left t))
                  (contains-bt? n (node-right t)))]))
         
