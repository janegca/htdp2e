;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-262-holes-in-scope) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 270. 
;
; Here is a simple ISL+ function:

; [List-of X] -> [List-of X]
; creates a version of the given list that is sorted in descending order 
(define (insertion-sort alon)
  (local ((define (sort alon)
            (cond
              [(empty? alon) '()]
              [else (add (first alon) (sort (rest alon)))]))
          (define (add an alon)
            (cond
              [(empty? alon) (list an)]
              [else
               (cond
                 [(> an (first alon)) (cons an alon)]
                 [else (cons (first alon) (add an (rest alon)))])])))
    (sort alon)))

; Draw a box around the scope of each binding occurrence of sort and alon.
; Then draw arrows from each occurrence of sort to the appropriate binding 
; occurrence. Now repeat the exercise for the following variant:

(define (sort.v1 alon)          ; can't use sort alone
  (local ((define (sort alon)
            (cond
              [(empty? alon) '()]
              [else (add (first alon) (sort (rest alon)))]))
          (define (add an alon)
            (cond
              [(empty? alon) (list an)]
              [else
               (cond
                 [(> an (first alon)) (cons an alon)]
                 [else (cons (first alon) (add an (rest alon)))])])))
    (sort alon)))

; Do the two functions differ other than in name?

; Ans: function appear to the same thing, a reverse sort of a number
;      list

(equal? (insertion-sort '(4 3 1 2 5)) (sort.v1 '(4 3 1 2 5)))


