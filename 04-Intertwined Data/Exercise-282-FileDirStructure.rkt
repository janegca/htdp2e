;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-282-FileDirStructure) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 282. 
;
; (see HtDP2e Draft IV Intertwined Data, Section 23.1 Data Analysis Figure 73)
;
; How many times does a file name read! occur in the directory tree TS?
; Ans: twice

; Can you describe the path from the root directory to the two occurrences?
; Ans:  TS -> read!
;       TS -> Libs -> Docs -> read!

; What is the total size of all the files in the tree?
; Ans:   (read! 10) 
;      + (part1 99) + (part2 52) + (part3 17) 
;      + (read! 19) + (hang 8)   + (draw 2) 
;      = 207

; What is the total size of the directory if each directory node has size 1? 
; Ans:   207 + (Text DIR) + (Libs Dir) + (Code Dir) + (Docs Dir)
;      = 207 + 4 = 211

; How many levels of directories does it contain?
; Ans:  TS              0
;        | Text         1
;        | Libs         1
;           | Code      2
;           | Docs      2


         


