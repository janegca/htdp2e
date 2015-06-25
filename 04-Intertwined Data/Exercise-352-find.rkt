;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname Exercise-352-find) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #t #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 352.
;
; Formulate test cases for find. Design find from scratch.

(define fsm-traffic
  '(("red" "green") ("green" "yellow") ("yellow" "red")))

; [List-of [List X Y]] X -> Y
; finds the matching Y for the given X in the association list
(check-expect (find fsm-traffic "red")   "green")
(check-expect (find fsm-traffic "green") "yellow")
(check-expect (find fsm-traffic "yellow") "red")
(check-error  (find fsm-traffic "blue"))

(define (find.v1 alist x)
  (local ((define fm (assoc x alist)))
    (if (cons? fm) (second fm) (error "next state not found"))))

(define (find alist x)
  (cond [(empty? alist) (error "next state not found")]
        [(equal? (first (first alist)) x) (second (first alist))]
        [else (find (rest alist) x)]))
                        

