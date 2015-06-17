;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-286-Model2-how-many) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 292. 
; 
; Design the function how-many, which determines how many files a given Dir.v2 
; contains. Exercise 291 provides you with data examples. Compare your result
; with that of exercise 290.

; -- Data Definitions
; A Dir.v2 is a structure: 
;   (make-dir Symbol LOFD)

; A LOFD (short for list of files and directories) is one of:
; – '()
; – (cons File.v2 LOFD)
; – (cons Dir.v2 LOFD)

; A File.v2 is a Symbol. 

(define-struct dir [name content])

; Dir.v2 -> Number
; number files in a file-directory tree

(check-expect (how-many (make-dir 'Test '())) 0)
(check-expect (how-many (make-dir 'Code '(hang draw))) 2)
(check-expect (how-many (make-dir 'Libs
                                  (list (make-dir 'Docs '(hang draw))
                                        (make-dir 'Code '(read!))))) 3)
(check-expect 
 (how-many 
  (make-dir 'TS
            (list 'read!
                  (make-dir 'Text 
                            '(part1 part2 part3))
                  (make-dir 'Libs 
                            (list (make-dir 'Docs '(read!))
                                  (make-dir 'Code '(hang draw)))))))
 7)

(define (how-many root)
  (local (; LOFD -> Number
          ; count the number of files in a list of files and directories
          (define (count-contents d)
            (cond [(empty? d) 0]
                  [(dir?    (first d))
                   (+ (how-many (first d))
                      (count-contents (rest d)))]
                  [else ; must be a file
                   (+ 1 (count-contents (rest d)))])))
    
    (count-contents (dir-content root))))

