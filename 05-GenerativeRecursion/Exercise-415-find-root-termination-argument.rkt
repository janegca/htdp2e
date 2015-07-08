;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-415-find-root-termination-argument) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 415.
;
; The find-root algorithm terminates for all (continuous) f, left, and right
; for which the assumption holds. Why? Formulate a termination argument.
;
; Hint Suppose the arguments of find-root describe an interval of size S1.
; How large is the distance between left a1nd right for the first, second,
; third recursive call to find-root? After how many steps is (- right left)
; smaller than or equal to TOLERANCE?

; Ans: holds as the interval is halved with each step, eventually isolating
;      the root; therefore, when the interval is <= the tolerance level
;      the funciton can safely terminate

; -- evaluating (find-root f 1 5) with TOLERACE = 0.5 (f = poly function)
;
;  step    left  right  mid  (f left)  (f right)  (f mid)        satisfies
;  n=1       1     5     3       3         3        -1              b
;  n=2       1     3     2       3        -1         0              c
;  n=3       1     2    1.5      3         0         1.25           c
;  n=4       1.5   2                                                a

; at step 4 (- right left) is <= TOLERANCE