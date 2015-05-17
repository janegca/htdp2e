;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-174-SearchSorted) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 174. 
;
; Here is the function search:

    ; Number List-of-numbers -> Boolean
    (define (search n alon)
      (cond
        [(empty? alon) #false]
        [else (or (= (first alon) n) (search n (rest alon)))]))

; It determines whether some number occurs in a list of numbers. The function
; may have to traverse the entire list to find out that the number of interest
; isn’t contained in the list.
;
; Develop the function search-sorted, which determines whether a number 
; occurs in a sorted list of numbers. The function must take advantage of the 
; fact that the list is sorted.

; Number List-of-Numbers -> Boolean
; returns true if the given number appears in the list of numbers
; sorted in descending order
(check-expect (search-sorted 1 '())             false)
(check-expect (search-sorted 1 (list 0 -1))     false)
(check-expect (search-sorted 1 (list 2 1 0 -1)) true)
(check-expect (search-sorted 3 (list 3 2 1))    true)

(define (search-sorted n lon)
  (cond [(empty? lon)      false]
        [(< (first lon) n) false]
        [else (or (= n (first lon)) (search-sorted n (rest lon)))]))

