;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-398-designing-quick-sort) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 398.
;
; Formulate informal answers to the four key questions for the quick-sort
; problem. How many instances of generate-problem are there?


; 1. What is a trivially solvable problem?
;    Ans: an empty list
;
; 2. How are trivial solutions solved?
;    Ans: return the desired answer for the situation, ie an empty list
;
; 3. How does the algorithm generate new problems that are more easily
;    solvable than the original one? Is there one new problem that we
;    generate or are there several?
;    Ans: splits the current list into 3 parts:
;         pivot - first item in list
;         part1 - all items that result in true when compared to the pivot
;         part2 - all items that result in false when compared to the pivot
;
; 4. Is the solution of the given problem the same as the solution of (one of)
;    the new problems? Or, do we need to combine the solutions to create a
;    solution for the original problem? And, if so, do we need anything from
;    the original problem data?
;    Ans: need to combine solutions; we need the compare function from
;         the original problem