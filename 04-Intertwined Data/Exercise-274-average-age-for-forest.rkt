;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-274-average-age-for-forest) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 274. 
; 
; Design the function average-age. It consumes a family forest and a year, 
; specified as a natural number. From this data, it produces the average age 
; of all child nodes in the forest. Note If the trees in this forest overlap, 
; the result isn’t a true average because some people may contribute more than 
; others. For this exercise, act as if the trees don’t overlap.

; -- data structures
(define-struct no-parent [])
(define-struct child [father mother name date eyes])

(define MTFT (make-no-parent))

; A FF (family forest) a [List-of FT]

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

; -- example forests
(define ff1 (list Carl Bettina))  ; two unrelated families
(define ff2 (list Fred Eva))      ; two unrelared families
(define ff3 (list Fred Eva Carl)) ; overlapping families

; -- Functions

; FT -> Number
; count the number of people in a family tree
(check-expect (count-persons MTFT)   0)
(check-expect (count-persons Carl)   1)
(check-expect (count-persons Gustav) 5)

(define (count-persons ft)
  (cond [(no-parent? ft) 0]
        [ else (+ 1 (count-persons (child-father ft))
                    (count-persons (child-mother ft)))]))

; Child -> Number
; compute a person's age from given year
; (returns a function that takes a child)
(check-expect ((compute-age 2015) MTFT) 0)
(check-expect ((compute-age 2015) Carl) (- 2015 1926))

(define (compute-age year)
  (lambda (person)
    (cond [(no-parent? person) 0]
        [else (- year (child-date person))])))

; [List-of FT] Number -> Number
; compute the average age of all children in the forest
; (ignores overlapping trees)
(check-expect (average-ages ff1 2015) (/ 179 2))
(check-expect (average-ages ff2 2015) (/  99 4))
(check-expect (average-ages ff3 2015) (/ 188 5))

(define (average-ages ff year)
  (/ (foldr + 0 (map (compute-age year) ff))  ; sum of all ages
     (foldr + 0 (map count-persons ff))))     ; sum of all person counts

