;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-363-Simplified-tree-pick) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 363.
;
; Simplify the function points-to from exercise 361.

    (define-struct branch [left right])
    ; A TOS is one of:
    ; – Symbol
    ; – (make-branch TOS TOS)
     
    ; A Direction is one of:
    ; – 'left
    ; – 'right
     
    ; A list of Directions is also called a path. 


; -- example trees
(define t0 'a)
(define t1 (make-branch 'a '()))
(define t2 (make-branch '() 'b))
(define t3 (make-branch 'b (make-branch 'a (make-branch 'c 'd))))
(define t4 (make-branch (make-branch 'a
                                     (make-branch 'b '()))
                        (make-branch 'c 'd)))
                                                        
; TOS Path -> Symbol
; follows the path (dirs) into the tree (tos) to retrieve the desired symbol
(check-expect (tree-pick t0 '())      'a)
(check-expect (tree-pick t1 '(left))  'a)
(check-expect (tree-pick t2 '(right)) 'b)
(check-expect (tree-pick t3 '(right right left)) 'c)
(check-expect (tree-pick t4 '(left right left))  'b)

(check-error (tree-pick t0 '(left)) "tree-pick: symbol before path end")
(check-error (tree-pick t1 '()) "tree-pick: path empty before symbol reached")

(define (tree-pick tos dirs)
  (cond [(empty? dirs)
         (if (symbol? tos)
             tos
             (error 'tree-pick "path empty before symbol reached"))]
        [(symbol? tos) (error 'tree-pick "symbol before path end")]
        [(eq? 'left (first dirs))
              (tree-pick (branch-left tos) (rest dirs))]
        [else (tree-pick (branch-right tos) (rest dirs))]))              

