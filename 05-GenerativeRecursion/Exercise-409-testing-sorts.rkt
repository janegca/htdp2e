;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-409-testing-sorts) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
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

; -- modified version of insertion sort from 1203-SP-InsertionSort
; Design a function that sorts a list of (real) numbers.

; List-of-numbers -> List-of-numbers 
; rearrange a list of numbers (alon) in descending order 
(check-expect (sort> '()) '()) 
(check-expect (sort> (list 12 20 -5)) (list 20 12 -5)) 
(check-expect (sort> (list 3 2 1)) (list 3 2 1))
(check-expect (sort> (list 1 2 3)) (list 3 2 1))

(define (sort> alon)
  (local ((define (insert n alon) 
            (cond    [(empty? alon) (cons n '())]   
                     [else (if (>= n (first alon))    
                               (cons n alon)         
                               (cons (first alon) (insert n (rest alon))))])))
    (cond    [(empty? alon) '()]  
             [else (insert (first alon) (sort> (rest alon)))])))

; -- quick-sort from Exercise 402
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

; -- code for this exercise

; create a list of the given length with values under 100
(define (bld-test-list len)
  (build-list len (lambda (x) (random 100))))

; Number Number -> [List-of Number]
; create a list of test lists whose lengths are given in s*
(define (create-tests s*)  
  (cond [(empty? s*) '()]
        [else (cons (bld-test-list (first s*))
                    (create-tests (rest s*)))]))

(define (run-sort-tests t*)
  (local (; aovid printing of full list on completion
          (define (time-sort> t)
            (local ((define t1 (sort> t)))  ; desc sort
              empty)))
    
    (cond [(empty? t*) '()]
          [else (cons (time (time-sort> (first t*)))
                      (run-sort-tests   (rest t*)))])))

(define (run-qs-tests t*)
  (local (; avoid printing out of full list on completion
          (define (time-qs t)
            (local ((define t1 (quick-sort t >))) ; desc sort
              empty)))
    
    (cond [(empty? t*) '()]
          [else (cons (time (time-qs (first t*)))
                      (run-qs-tests  (rest t*)))])))

; -- Example test set
(define s1 (create-tests (list 1 10 100 500 1000)))

; -- example output
;    > (run-sort-tests s1)
;    cpu time:   0 real time:   1 gc time: 0       1
;    cpu time:   0 real time:   0 gc time: 0       10
;    cpu time:  16 real time:   7 gc time: 0       100
;    cpu time: 141 real time: 150 gc time: 0       500
;    cpu time: 609 real time: 620 gc time: 0       1000
;    (list '() '() '() '() '())
;    > (run-qs-tests s1)
;    cpu time:  0 real time:  1 gc time: 0         1
;    cpu time:  0 real time:  0 gc time: 0         10
;    cpu time:  0 real time:  1 gc time: 0         100
;    cpu time: 15 real time:  6 gc time: 0         500
;    cpu time: 16 real time: 13 gc time: 0         1000
;    (list '() '() '() '() '())
;    >

; difference, for these two specific implementations, consistently
; kicks in at the 100 length, with quick-sort beating out sort>
; in real time; so, use sort> below length 100, quick-sort above
; however, quick-sort worked just as well with short lists so
; not much need to switch to sort> in quick-sort for shorter lists

