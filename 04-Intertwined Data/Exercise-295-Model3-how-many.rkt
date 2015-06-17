;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-289-Model3-how-many) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 295. 
; 
; Design the function how-many, which determines how many files a given Dir.v3 
; contains. Exercise 294 provides you with data examples. Compare your result
; with that of exercise 292.
;
; Given the complexity of the data definition, contemplate how anyone can
; design correct functions. Why are you confident that how-many produces
; correct results? 

(define-struct file [name size content])
; A File.v3 is a structure: 
;   (make-file Symbol N String)

(define-struct dir.v3  [name dirs files])
; A Dir.v3 is a structure: 
;   (make-dir.v3 Symbol Dir* File*)
 
; A Dir* is one of: 
; – '()
; – (cons Dir.v3 Dir*)
 
; A File* is one of: 
; – '()
; – (cons File.v3 File*)

; Dir.v3 -> Number
; count the number of files in the directory structure

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

(check-expect (how-many.v1 (make-dir.v3 'Test empty empty)) 0)
(check-expect (how-many.v1 f73) 7)
                                     
(define (how-many.v1 root)
  (local (; Dir* -> Number
          ; the number of files in a list of directory structures
          (define (count-dirs d*)
            (cond [(empty? d*) 0]
                  [else (+ (how-many   (first d*))
                           (count-dirs (rest d*)))])))
  (cond [(empty? (dir.v3-dirs root))
         (+ 0 (length (dir.v3-files root)))]
        [else
         (+ (count-dirs (dir.v3-dirs root))
            (length   (dir.v3-files root)))])))

; simplified version of the above
; NOTE: possible because the structure separates directories and files
;       making it easier to handle each data type separately
(define (how-many root)
  (+ (foldr + 0 (map how-many (dir.v3-dirs root)))
     (length (dir.v3-files root))))

