;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-227-my-build-list) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 227. 
; 
; You can design build-list and foldl with the design recipes that you know, 
; but they are not going to be like the ones that ISL provides. For example,
; the design of your own foldl function requires a use of the list reverse 
; function:
;
    ; [X Y -> Y] Y [List-of X] -> Y
    ; my-foldl works just like foldl
    (check-expect (my-foldl cons '() '(a b c)) (foldl cons '() '(a b c)))
    (check-expect (my-foldl / 1 '(6 3 2)) (foldl / 1 '(6 3 2)))

(define (my-foldl f e l)
      (foldr f e (reverse l)))

; Design my-build-list, which works just like build-list. Hint: Recall the 
; add-at-end function from exercise 178. Note: Accumulators covers the concepts 
; that you need to design these functions properly.

; Number [Number -> X] -> [List-of X]
(check-expect (my-build-list 4 add1) (build-list 4 add1))

(define (my-build-list n f)
  (bld-lst n 0 f))
  
(define (bld-lst n v f)
  (cond [(= v n) '()]
        [else (cons (f v) (bld-lst n (+ v 1) f))]))
ss