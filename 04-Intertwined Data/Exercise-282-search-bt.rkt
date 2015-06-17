;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-282-search-bt) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 282. 
; 
; Design search-bt. The function consumes a number n and a BT. If the tree 
; contains a node structure whose ssn field is n, the function produces the
; value of the name field in that node. Otherwise, the function produces
; #false.
;
; Hint: Use either contains-bt? to produce #false if called for or boolean? 
;       to find out whether search-bt is successfully used on a subtree. 


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

; -- contains-bt from Exercise 281
; Number BT -> Boolean
; #true if the number is found in the tree
(define (contains-bt? n t)
  (cond [(eq? NONE t)       #false]
        [(= n (node-ssn t)) #true]
        [else (or (contains-bt? n (node-left t))
                  (contains-bt? n (node-right t)))]))

; Number BT -> [Maybe Symbol]
; the person's name if the ssn is found in the tree, otherwise false
(check-expect (search-bt 87 n1) 'a)
(check-expect (search-bt 33 n8) 'c)
(check-expect (search-bt 24 n9) 'b)
(check-expect (search-bt 10 n9) #false)

(define (search-bt n t)
  (cond [(eq? NONE t) #false]
        [(= n (node-ssn t)) (node-name t)]
        [(contains-bt? n (node-left t)) 
         (search-bt n (node-left t))]
        [else (search-bt n (node-right t))]))

  

