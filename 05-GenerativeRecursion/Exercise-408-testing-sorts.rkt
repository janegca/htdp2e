;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-408-testing-sorts) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 409.
;
; Add sort> and quick-sort to the definitions area. Run tests on the functions
; to ensure that they work on basic examples. Also develop create-tests, a
; function that creates large test cases randomly. Then explore how fast each
; works on various lists.
;
; Does the experiment confirm the claim that the plain sort> function wins in
; many comparisons over quick-sort for short lists and vice versa?

; Determine the cross-over point. Use this information to build a clever-sort
; function that behaves like quick-sort for large lists and switches over to
; the plain sort> function for lists below this cross-over point.
; See exercise 393.

; -- from Exercise 231

; Lon -> Lon
; constructs a list from the items in l in descending order
(check-expect (sort> '()) '())
(check-expect (sort> (list 1 2 3)) (list 3 2 1))
(check-expect (sort> (list 3 1 4 2)) (list 4 3 2 1))

(define (sort> l0)
  (local (; Lon -> Lon
          (define (sort l)
            (cond
              [(empty? l) '()]
              [else (insert (first l) (sort (rest l)))]))
          
          ; Number Lon -> Lon 
          (define (insert an l)
            (cond
              [(empty? l) (list an)]
              [else
               (cond
                 [(> an (first l)) (cons an l)]
                 [else (cons (first l) (insert an (rest l)))])])))
    ; - IN -
    (sort l0)))


; -- from Exercise 402
; [List-of Number] (N N -> Boolean) -> [List-of Number]
; creates a list of numbers with the same numbers as
; alon, sorted according to the comparison operator
(check-expect (quick-sort '() <) '())
(check-expect (quick-sort '(7) <) '(7))
(check-expect (quick-sort (list 11 8 14 7) <)    '(7 8 11 14))
(check-expect (quick-sort (list 11 8 14 11 7) <) '(7 8 11 11 14))
(check-expect (quick-sort (list 11 8 14 11 7) >) '(14 11 11 8 7))

(define (quick-sort alon cmp)
  (cond
    [(empty? alon) '()]
    [(empty? (rest alon)) (list (first alon))]
    [else (local ((define pivot (first alon))
                  (define part1
                    (filter (lambda (m) (cmp m pivot)) (rest alon)))
                  (define part2
                    (filter (lambda (m) (not (cmp m pivot))) (rest alon))))
            (append (quick-sort part1 cmp)
                    (list pivot)
                    (quick-sort part2 cmp)))]))

; Number Number -> [List-of Number]
; create a list of test lists whose length is within the range of maxlen
(define (create-tests n maxlen)
  (local (; create a list of the given length with values under 100
          (define (test-list len)
            (build-list len (lambda (x) (random 100)))))
    
    (cond [(eq? n 0) '()]
          [else (cons (test-list (random maxlen))
                      (create-tests (- n 1) maxlen))])))

(define (time-sort> t)
  (local ((define t1 (sort> t)))
    ""))

(define (time-qs t)
  (local ((define t1 (quick-sort t <)))
    ""))

(define (run-sort-tests t*)
  (cond [(empty? t*) ""]
        [(empty? (first t*)) ""]
        [else (string-append (time (time-sort> (first t*)))
                             (run-sort-tests (rest t*)))]))

(define (run-qs-tests t*)
  (cond [(empty? t*) ""]
        [(empty? (first t*)) ""]
        [else (string-append (time (time-qs (first t*)))
                             (run-sort-tests (rest t*)))]))

; -- example test sets
(define tests    (create-tests 20 1000))
(define testLens (map length tests))

(define shortLists (create-tests 20 100))
(define shortLens  (map length shortLists))
