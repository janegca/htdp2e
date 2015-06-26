;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-361-tree-pick) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 361.
;
; Design the function tree-pick. The function consumes a tree of symbols and
; a list of directions:

    (define-struct branch [left right])
    ; A TOS is one of:
    ; – Symbol
    ; – (make-branch TOS TOS)
     
    ; A Direction is one of:
    ; – 'left
    ; – 'right
     
    ; A list of Directions is also called a path. 

; Clearly a Direction tells the function whether to choose the left or the
; right branch in a non-symbolic tree. The function signals an error when it
; is given a symbol and a non-empty path.

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
  (cond [(and (symbol? tos) (empty? dirs)) tos]      
        [(and (symbol? tos) (not (empty? dirs)))      
         (error 'tree-pick "symbol before path end")]
        [(and (branch? tos) (empty? dirs))
         (error 'tree-pick "path empty before symbol reached")]
        [(eq? 'left (first dirs))
         (tree-pick (branch-left tos) (rest dirs))]
        [else (tree-pick (branch-right tos) (rest dirs))]))
  



