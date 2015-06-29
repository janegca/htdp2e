;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Exercise-398-HandEvaluation of QuickSort|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 392.
;
; Complete the hand evaluation.
;
; The hand evaluation of (quick-sort (list 11 8 14 7)) suggests an additional
; trivial case for quick-sort. Every time quick-sort consumes a list of one
; item, it produces the very same list. After all, the sorted version of a
; list of one item is the list itself.
;
; Modify the definition of quick-sort to take advantage of this observation.
;
; Hand evaluate the example again. How many steps does the extended algorithm
; save?

; -- Hand Evaluation
;
;(quick-sort (list 11 8 14 7))
;==
;(append (quick-sort (list 8 7))
;        (list 11)
;        (quick-sort (list 14)))
;==
;(append (append (quick-sort (list 7))
;                 (list 8)
;                (quick-sort '()))
;        (list 11)
;        (quick-sort (list 14)))
;==
;(append (append (append (quick-sort '())
;                        (list 7)
;                        (quick-sort '()))
;                (list 8)
;                (quick-sort '()))
;        (list 11)
;        (quick-sort (list 14)))
;==
;(append (append (append '()
;                         (list 7)
;                        '())
;                (list 8)
;                '())
;        (list 11)
;        (quick-sort (list 14)))
;==
;(append (append (list 7)
;                (list 8)
;                '())
;        (list 11)
;        (quick-sort (list 14)))
;==
;(append (list 7 8)
;        (list 11)
;        (quick-sort (list 14)))
;==
;(append (list 7 8)
;        (list 11)
;        (append '()
;                (list 14)
;                '()))
;==
;(append (list 7 8)
;        (list 11)
;        (14))
; (list 7 8 11 14)
;
;
; If the modification is made, the hand evaluation becomes
;
;(quick-sort (list 11 8 14 7))
;==
;(append (quick-sort (list 8 7))
;        (list 11)
;        (quick-sort (list 14)))
;==
;(append (append (quick-sort (list 7))
;                 (list 8)
;                (quick-sort '()))
;        (list 11)
;        (quick-sort (list 14)))
;==
;(append (append (list 7)
;                (list 8)
;                (quick-sort '()))
;        (list 11)
;        (quick-sort (list 14)))
;==
;(append (append (list 7)
;                (list 8)
;                '())
;        (list 11)
;        (quick-sort (list 14)))
;==
;(append (append (list 7)
;                (list 8)
;                '())
;        (list 11)
;        (quick-sort (list 14)))
;==
;(append (append (list 7)
;                (list 8)
;                '())
;        (list 11)
;        (quick-sort (list 14)))
;==
;(append (append (list 7)
;                (list 8)
;                 '())
;        (list 11)
;        (list 14)))
;==
;(append (list 7 8)
;        (list 11)
;        (14))
; (list 7 8 11 14)
;
; Saves 3 partition steps and 3 combination steps
