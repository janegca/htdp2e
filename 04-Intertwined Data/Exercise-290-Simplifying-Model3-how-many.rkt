;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-280-Simplifying-Model3-how-many) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 290. 
;
; Use List-of to simplify the data definition Dir.v3. Then use ISL+’s list
; processing functions from figure 56 to simplify the function definition(s) 
; for the solution of exercise 289.

(define-struct file [name size content])
; A File is a structure: 
;   (make-file Symbol N String)

(define-struct dir.v3  [name dirs files])
; A Dir.v3 is a structure: 
;   (make-dir.v3 Symbol LOD LOF)
 
; A LOD is one of: 
; – '()
; – (cons Dir.v3 LOD)
 
; A LOF is one of: 
; – '()
; – (cons File.v3 LOF)

; -- Figure 73 as a Model 3 directory structure
(define f73
(make-dir.v3 'TS
             (list (make-dir.v3 'Text
                                '() 
                                (list (make-file 'part1 99 "")
                                      (make-file 'part2 52 "")
                                      (make-file 'part3 17 "")))
                   (make-dir.v3 'Libs 
                                (list (make-dir.v3 'Code 
                                                   '() 
                                                   (list 
                                                    (make-file 'hang 8 "")
                                                    (make-file 'draw 2 "")))
                                      (make-dir.v3 'Docs 
                                                   '() 
                                                   (list
                                                    (make-file 'read! 19 ""))))
                                '()))
             (list (make-file 'read! 10 ""))))

; Dir.v3 -> Number
; the number of files in a directory structure

(check-expect (how-many (make-dir.v3 'Test empty empty)) 0)
(check-expect (how-many (make-dir.v3 'Docs 
                                     empty
                                     (list (make-file 'read! 19 "")))) 1)
(check-expect (how-many (make-dir.v3 'D1
                                     (list 
                                      (make-dir.v3 'D1A
                                                   empty 
                                                   (list
                                                    (make-file 'read! 10 ""))))
                                     empty)) 1)
                                     
(check-expect (how-many f73) 7)

(define (how-many root)
  (+ (foldr + 0 (map how-many (dir.v3-dirs root)))
     (length (dir.v3-files root))))

