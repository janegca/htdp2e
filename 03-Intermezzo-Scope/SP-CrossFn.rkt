;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname SP-CrossFn) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Sample Problem:
; 
; Design cross. The function consumes two lists, l1 and l2, and produces 
; pairs of all items from l1 and l2.


; If you designed cross properly, you worked through a table such as this one:
;   cross      'a           'b          'c
;     1     (list 'a 1)  (list 'b 1)  (list 'c 1)
;     2     (list 'a 2)  (list 'b 2)  (list 'c 2)

; The first row displays l1 as given, while the left-most column shows l2. 
; Each cell in the table corresponds to one of the pairs that cross must 
; generate.

; -- using existing abstractions

; [List-of X] [List-of Y] -> [List-of [List X Y]]
; generate all possible pairs of items from l1 and l2
(define t1 (lambda (c) (= (length c) 6)))
(check-satisfied (cross '(a b c) '(1 2)) t1)

(define (cross l1 l2)
  (local ((define (rows i)
            (local ((define (element j) 
                      (list (list-ref l1 j) 
                            (list-ref l2 i))))
                      (build-list (length l1) element))))
    (foldr append '() (build-list (length l2) rows))))

(equal? (cross '(a b c) '(1 2))
         (list (list 'a 1) (list 'b 1) (list 'c 1)
               (list 'a 2) (list 'b 2) (list 'c 2)))

; -- using for*/list (not currently available in h2dp teachpacks)

; [List-of X] [List-of Y] -> [List-of [List X Y]]
; generate all possible pairs of items from l1 and l2
;(check-satisfied (cross '(a b c) '(1 2)) (lambda (c) (= (length c) 6)))
;
;(define (cross l1 l2)
;   (for*/list ([item1 l1][item2 l2])
;      (list item1 item2)))