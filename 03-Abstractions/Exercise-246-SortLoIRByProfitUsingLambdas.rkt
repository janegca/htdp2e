;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-246-SortLoIRByProfitUsingLambdas) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 246
;
; Re-write Exercise 233 using lambda's vs local functions

(define-struct ir [name desc ap sp])
; An IR is a (make-ir String String Number Number)
; interpretation: (make-ir name desc ap sp) combines the elements of
; an inventory item into a record representing the items name,
; description (desc), acquisition price (ap) and sales price (sp).

; [List-of IR] -> [List-of IR]
; returns a list of inventory items sorted on the difference between
; their acquisition and sale prices
(check-expect (items-by-profit '()) '())
(check-expect (items-by-profit (list (make-ir "item 1" "desc 1"  25  30)
                                     (make-ir "item 2" "desc 2" 120 140)
                                     (make-ir "item 3" "desc 3"   .5  .5)
                                     (make-ir "item 4" "desc 4"   1   4)))
              (list (make-ir "item 2" "desc 2" 120 140)
                    (make-ir "item 1" "desc 1"  25  30)
                    (make-ir "item 4" "desc 4"   1   4)
                    (make-ir "item 3" "desc 3"   .5  .5)))

(define (items-by-profit loir)
    (sort-a loir 
            (lambda (a b) (> (- (ir-sp a) (ir-ap a)) 
                             (- (ir-sp b) (ir-ap b))))))

; NOTE: re-using sort-a from Exercise 231
;
; [List-of Number] [Number Number -> Boolean] -> [List-of Number]
(check-expect (sort-a '() >) '())
(check-expect (sort-a (list 1 2 3) >) (list 3 2 1))
(check-expect (sort-a (list 3 1 4 2) >) (list 4 3 2 1))
(check-expect (sort-a '() <) '())
(check-expect (sort-a (list 3 2 1) <) (list 1 2 3))
(check-expect (sort-a (list 3 1 4 2) <) (list 1 2 3 4))

(define (sort-a lon cmp)
      (local (; Lon -> Lon
              (define (sort l)
                (cond
                  [(empty? l) '()]
                  [else (insert (first l) (sort (rest l)))]))
              
              ; Number Lon -> Lon 
              (define (insert an l)
                (cond
                  [(empty? l) (list an)]
                  [else
                   (cond
                     [(cmp an (first l)) (cons an l)]
                     [else (cons (first l) (insert an (rest l)))])])))
        ; - IN -
        (sort lon)))
