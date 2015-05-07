;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-092-ZooAnimals) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 92. 
;
; Develop a data representation for the following four kinds of zoo animals:
;
;   spiders, whose relevant attributes are the number of remaining legs 
;   (we assume that spiders can lose legs in accidents) and the space they 
;    need in case of transport
;
;   elephants, whose only attributes are the space they need in case of 
;   transport
;
;   boa constrictor, whose attributes include length and girth, and
;
;   armadillo, for whom you must determine appropriate attributes
;   they need to include attributes that determine space needed for 
;   transportation.
;
; Develop a template for functions that consume representations of zoo 
; animals.
;
; Design the function fits?. The function consumes a zoo animal and the 
; volume of a cage. It determines whether the cage is large enough for the 
; animal. 

(define-struct spider [legs space])
; is (make-spider Number Number)
; interpretation: the number of a spider's remaining legs and the space
; required for his transport
;
;    ( ... (spider-legs s) ... (spider-space s) ... )

(define-struct elephant [space])
; is (make-elephant Number)
; interpretation: the space needed to transport an elephant
;
;    ( ... (elephant-space e) ... )

(define-struct boa [length girth space])
; is (make-boa Number Number Number)
; interpretation: the length and girth of a boa-constrictor and the space
; needed to transport it
;
;     ( ... (boa-length b) ... (boa-girth b) ... (boa-space b) ... )

(define-struct armadillo [diameter space])
; is (make-armadillo Number Number)
; interpretation: the diameter of an armadillo and the space needed to
; transport it
;
;    ( ... (armadillo-diameter a) ... (armadillo-space a) ... )


; Animal Cage -> Boolean
; returns true if the space required to transport a given zoo animal
; is less than or equal to the given cage volume
(check-expect (fits? (make-spider 8 30)     50)   true)
(check-expect (fits? (make-elephant 100)    50)  false)
(check-expect (fits? (make-boa 20 5 100)   100)   true)
(check-expect (fits? (make-armadillo 20 25) 30)   true)
(check-expect (fits? 10 10)                      false)

(define (fits? a c)
  (cond
    [(spider? a)    (<= (spider-space a)     c)]
    [(elephant? a)  (<= (elephant-space a)   c)]
    [(boa? a)       (<= (boa-space a)        c)]
    [(armadillo? a) (<= (armadillo-space a) c)]
    [else false]))
