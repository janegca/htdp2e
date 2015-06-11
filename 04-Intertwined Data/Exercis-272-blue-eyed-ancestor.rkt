;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercis-272-blue-eyed-ancestor) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 272. 
; 
; Suppose we need the function blue-eyed-ancestor?. It is like 
; blue-eyed-child? but responds with #true only when an ancestor,
; not the given child node, has blue eyes.
;
; Even though the functions differ, their signatures are the same:

    ; FT -> Boolean
    ; does a-ftree contain a child node with blue eyes
    ;(define (blue-eyed-ancestor? a-ftree) ...)

; To appreciate the difference, we take a look at Eva:

;    (check-expect (blue-eyed-child? Eva) #true)

; Eva is blue-eyed. Because she does not have a blue-eyed ancestor, however,
; we get

;    (check-expect (blue-eyed-ancestor? Eva) #false)

; Now suppose a friend comes up with this solution:

    (define (blue-eyed-ancestor? a-ftree)
      (cond
        [(no-parent? a-ftree) #false]
        [else (or (blue-eyed-ancestor? (child-father a-ftree))
                  (blue-eyed-ancestor? (child-mother a-ftree)))]))

; Explain why this function fails the above test. What is the result of 
; (blue-eyed-ancestor? A) no matter which A you choose? Can you fix your 
; friend’s solution?

; -- data structures
(define-struct no-parent [])
(define-struct child [father mother name date eyes])

(define MTFT (make-no-parent))


; -- example family tree

; oldest generation
(define Carl    (make-child MTFT MTFT "Carl"    1926 "green"))
(define Bettina (make-child MTFT MTFT "Bettina" 1925 "green"))

; middle generation
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva  (make-child Carl Bettina "Eva"  1965 "blue"))
(define Fred (make-child MTFT MTFT "Fred"    1966 "pink"))

; youngest generation
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

; this actually passes, in fact, any test with #false will
; pass for any given FT and the eye-color is not being checked
; anywhere in the given code
; the following should pass (as Gustav does have a blue-eyed ancestor,
; Eva, but it fails

(check-expect (blue-eyed-ancestor? Gustav) #true)

; fix for blue-eyed-ancestor?
(check-expect (blue-eyed-ancestor?.fix MTFT)   #false)
(check-expect (blue-eyed-ancestor?.fix Eva)    #false)
(check-expect (blue-eyed-ancestor?.fix Gustav) #true)

(define (blue-eyed-ancestor?.fix a-ftree)
  (cond
    [(no-parent? a-ftree) #false]
    [(or (string=? "blue" (child-eyes (child-father a-ftree)))
         (string=? "blue" (child-eyes (child-mother a-ftree))))
     #true]
    [else (or (blue-eyed-ancestor? (child-father a-ftree))
              (blue-eyed-ancestor? (child-mother a-ftree)))]))
