;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-270-average-age) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 270. 
; 
; Develop the function average-age. It consumes a family tree node and the 
; current year. It produces the average age of all child structures in the 
; family tree. 

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

; count-persons function from Exercise 269
; FT -> Number
; count the number of people in a family tree
(check-expect (count-persons MTFT)   0)
(check-expect (count-persons Carl)   1)
(check-expect (count-persons Gustav) 5)

(define (count-persons ft)
  (cond [(no-parent? ft) 0]
        [ else (+ 1 (count-persons (child-father ft))
                    (count-persons (child-mother ft)))]))

; FT Number -> Number
; returns the average age of all persons in a family tree given the current year
(check-expect (average-age MTFT 2015) 0)
(check-expect (average-age Carl 2015) (- 2015 1926))
(check-within (average-age Adam 2015) (/ (+ (- 2015 1950) 
                                            (- 2015 1926)
                                            (- 2015 1926)) 3)
              1)

(define (average-age ft year)
  (local (; count of persons in the original tree
          (define count (count-persons ft))
          
          ; FT -> (List-of Number)
          ; compute the ages of all persons in the tree
          ; based on the given year
          (define (ages t)
            (cond [(no-parent? t) 0]
                  [else (+ (- year (child-date t))
                           (ages   (child-father t))
                           (ages   (child-mother t)))])))
    (if (= 0 count)
        0
        (/ (ages ft) count))))

