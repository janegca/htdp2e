;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-286-create-bst-from-list) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 286. 
; 
; Design the function create-bst-from-list. It consumes a list of numbers and 
; names and produces a binary search tree by repeatedly applying create-bst. Here is the signature:

; [List-of [List Number Symbol]] -> BST

; Once you have completed the design, create a BST from the following sample 
;input:

(define sample
  '((99 o)
    (77 l)
    (24 i)
    (10 h)
    (95 g)
    (15 d)
    (89 c)
    (29 b)
    (63 a)))

; The result is tree A in figure 73 if you follow the structural design 
; recipe. If you use an existing abstraction, you may still get this tree but 
; you may also get an “inverted” one. Why?

; from Exercise 286

(define-struct no-info ())
(define NONE (make-no-info))

(define-struct node (ssn name left right))
; A BinaryTree (short: BT) is one of:
; – NONE
; – (make-node Number Symbol BT BT)

; BST Number Symbol -> BST
; a BST with the node Number Symbol inserted in correct tree sort order
(check-expect (create-bst (make-node 6 'n NONE NONE) 6 'n)
              (make-node 6 'n NONE NONE))

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

; [List-of [List Number Symbol]] -> BST
(check-expect (create-bst-from-list '((99 o)))
              (make-node 99 'o NONE NONE))

(define (create-bst-from-list vals)
  (cond [(empty? vals) NONE]
        [ else (create-bst (create-bst-from-list (rest vals))
                           (first (first vals))
                           (second (first vals)))]))

; -- usage
(define treeA (create-bst-from-list sample))
