;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname |1801-Example-Composing Functions|) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; 18-01 - Example  - Composing Functions

; 1. design a function that extracts the first names from the given list 
;    of Addr;
;
; 2. design a function that sorts these names in alphabetical order;
;
; 3. design a function that concatenates the strings from step 2.
;
; Before you read on, you may wish to execute this plan. That is, design all
; three functions and then compose them in the sense of Composing Functions
; to obtain your own version of listing.

(define-struct address [first-name last-name street])
; Addr is (make-address String String String)
; interpretation associates a street address with a person's name
 
(define ex01 (list (make-address "John" "Lennon" "Penny Lane")
                   (make-address "Paul" "McCartney" "Strawberry Fields")
                   (make-address "George" "Harrison" "Karma Road")
                   (make-address "Ringo" "Starr" "Octopu's Garden")))

; [List-of Address] -> [List-of String]
; extract the first names from a list of addresses
(check-expect (first-names ex01)
              (list "John" "Paul" "George" "Ringo"))

(define (first-names aloa)
  (cond [(empty? aloa) '()]
        [else (cons (address-first-name (first aloa))
                    (first-names (rest aloa)))]))

; [List-of Addresses] [String String -> String] -> [Sorted-List-of String]
; sort a list of first names from the given addresses using the given function
(check-expect (sort-names ex01 string<?)
              (list "George" "John" "Paul" "Ringo"))
(check-expect (sort-names ex01 string>?)
              (list "Ringo" "Paul" "John" "George"))

(define (sort-names aloa f)
  (sort (first-names aloa) f))

; [List-of Addresses] -> String
; gets the first names from a list of addresses as a string
; names are sorted in ascending order
(check-expect (get-first-names ex01)
              "George John Paul Ringo ")

(define (get-first-names aloa)
  (append-space (sort-names aloa string<?)))

; [List-of String] -> String
; add a space between each list element and return result as
; a single string
(define (append-space lst)
  (cond [(empty? lst) ""]
        [else (string-append (first lst)
                             " "
                             (append-space (rest lst)))]))


; or, using text example 
; - HIGHER ORDER FUNCTIONS MEAN YOU DON'T NEED TO WRITE AS
;   MANY 'EXTRA' FUNCTIONS
; 
; [List-of Addr] -> String 
; creates a string of first names, sorted in alphabetical order,
; separated and surrounded by blank spaces
(check-expect (listing ex01)
              " George John Paul Ringo ")

(define (listing l)
  (foldr string-append-with-space
         " "
         (sort (map address-first-name l) ; REMEMBER - address-first-name
               string<?)))                ;   is a 'getter' function created
                                          ;   when the structure is declared
                                          ; MAP is a higher order function
                                          ; that applies address-first-name
                                          ; to every item in a list
                                          ; SORT is another higher order function
                                          ; as is FOLDR

; String String -> String 
; concatenates two strings and prefixes with space 
(define (string-append-with-space s t)
  (string-append " " s t))
        