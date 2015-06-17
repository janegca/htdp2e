;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-291-UsingHowManyWithCreateDir) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 297.
; 
; Use create-dir to create data representations of some sample directories
; on your computer. Then use how-many from exercise 295 to count how many 
; files they contain. Why are you confident that how-many produces correct 
; results for these directories?

(require htdp/dir)

; on Windows
(define save     (create-dir "c:\\save"))
(define articles (create-dir "c:\\Users\\Jane\\Documents\\Articles"))
(define bard     (create-dir "c:\\Users\\Jane\\Documents\\ebooks\\Shakespeare"))
(define ebooks   (create-dir "c:\\Users\\Jane\\Documents\\ebooks"))

; Dir -> Number
; the number of files in a directory structure
(check-expect (how-many save) 1)
(check-expect (how-many articles) 1)
(check-expect (how-many bard) 7)
(check-expect (how-many ebooks) 106)

(define (how-many root)
  (+ (foldr + 0 (map how-many (dir-dirs root)))
     (length (dir-files root))))
