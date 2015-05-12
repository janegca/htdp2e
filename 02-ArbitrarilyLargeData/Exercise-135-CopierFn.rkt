;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-135-CopierFn) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 135. 
; Does copier function properly when you apply it to a natural number 
; and a Boolean or an image? Or do you have to design another function?
;
; An alternative definition of copier (copier.v2) might use else for the 
; second condition. How do copier and copier.v2 behave when you apply them 
; to 10.1 and "xyz"? Explain. 

; Answer: (a) works fine, don't need to write another function
;         (b) the behave the same way (n is a natural number and they
;             are all constructed the same way so n can only be
;             zero or a postive number)
;

; N String -> List-of-strings 
; creates a list of n strings s 
(check-expect (copier 2 "hello") (cons "hello" (cons "hello" '())))
(check-expect (copier 0 "hello") '())
(check-expect (copier 4 0) (cons 0(cons 0(cons 0(cons 0 '())))))
(check-expect (copier 2 (circle 3 "solid" "red"))
              (cons (circle 3 "solid" "red")
                    (cons (circle 3 "solid" "red") '())))

(define (copier n s) 
  (cond    [(zero? n) '()] 
           [(positive? n) (cons s (copier (sub1 n) s))]))

; alternative version of copier
(check-expect (copier.v2 2 10.1) (copier 2 10.1))
(check-expect (copier.v2  3 "xyz") (copier 3 "xyz"))

(define (copier.v2 n s)
  (cond    [(zero? n) '()]  
           [else (cons s (copier.v2 (sub1 n) s))]))

