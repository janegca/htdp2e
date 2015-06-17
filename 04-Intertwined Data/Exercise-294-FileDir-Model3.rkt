;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-288-FileDir-Model3) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 294.
; 
; Translate the directory tree in figure 74 into a data representation 
; according to model 3. Use "" for the content of files.


(define-struct file [name size content])
; A File.v3 is a structure: 
;   (make-file Symbol N String)

(define-struct dir.v3 [name dirs files])
; A Dir.v3 is a structure: 
;   (make-dir.v3 Symbol Dir* File*)
 
; A Dir* is one of: 
; – '()
; – (cons Dir.v3 Dir*)
 
; A File* is one of: 
; – '()
; – (cons File.v3 File*)

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
            (list (make-file 'read! 10 "")))
         