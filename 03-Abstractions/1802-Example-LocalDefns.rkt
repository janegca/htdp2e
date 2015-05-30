;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname 1802-Example-LocalDefns) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; 18.02 Examples - Local Definitons

; List of first names in Address re-written to use local definitions

(define-struct address [first-name last-name street])
; Addr is (make-address String String String)
; interpretation associates a street address with a person's name
 
(define ex01 (list (make-address "John" "Lennon" "Penny Lane")
                   (make-address "Paul" "McCartney" "Strawberry Fields")
                   (make-address "George" "Harrison" "Karma Road")
                   (make-address "Ringo" "Starr" "Octopu's Garden")))


; [List-of Addr] -> String 
; creates a string of first names, sorted in alphabetical order,
; separated and surrounded by blank spaces
(check-expect (listing.v2 ex01)
              " George John Paul Ringo ")

(define (listing.v2 l)
  (local (; String String -> String 
          ; concatenates two strings and prefixes with space 
          (define (string-append-with-space s t)
            (string-append " " s t)))
    ; — IN —
    (foldr string-append-with-space
           " "
           (sort (map address-first-name l)
                 string<?))))

; streamlining listing even more
(check-expect (listing.v3 ex01)
              " George John Paul Ringo ")

(define (listing.v3 l)
  (local (; String String -> String 
          ; concatenates two strings and prefixes with space 
          (define (string-append-with-space s t)
            (string-append " " s t))
          (define first-names (map address-first-name l))
          (define sorted-names (sort first-names string<?)))
    ; — IN —
    (foldr string-append-with-space " " sorted-names)))


; -- Example of sorting a list based on the given comparison function

; [List-of Number] [Number Number -> Boolean] -> [List-of Number]
(check-expect (sort-cmp (list 4 3 2 1) <) (list 1 2 3 4))
(check-expect (sort-cmp (list 1 2 3 4) >=) (list 4 3 2 1))
(check-expect (sort-cmp (list 3 4 1 2) <) (list 1 2 3 4))

(define (sort-cmp alon0 cmp)
  (local (; [List-of Number] -> [List-of Number]
          ; produces a variant of alon sorted by cmp
          (define (isort alon)
            (cond
              [(empty? alon) '()]
              [else (insert (first alon) (isort (rest alon)))]))
 
          ; Number [List-of Number] -> [List-of Number]
          ; inserts n into the sorted list of numbers alon 
          (define (insert n alon)
            (cond
              [(empty? alon) (cons n '())]
              [else (if (cmp n (first alon))
                        (cons n alon)
                        (cons (first alon)
                              (insert n (rest alon))))])))
    (isort alon0)))

; -- Local definitions can also show up in the middle of functions
;    and define variables

; Nelon -> Number
; determines the smallest number on l
(define (inf l)
  (cond
    [(empty? (rest l)) (first l)]
    [else
     (local
       ; local defintion to define a variable whose value 
       ; is the result of  a natural recursion
       ((define smallest-in-rest (inf (rest l))))
       (cond
         [(< (first l) smallest-in-rest) (first l)]
         [else smallest-in-rest]))]))

; the value of (inf (rest l)) is only evaluated once, befoe the body
; of the main function is evaluated, and then cached; can see this
; in checking the two lists from Exercise 211
; (inf t1) and (inf t2) now take roughly the same amount of processing time

(define t1
  (list 25 24 23 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1))

(define t2 
  (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25))

