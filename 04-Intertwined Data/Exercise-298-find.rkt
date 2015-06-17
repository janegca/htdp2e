;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-292-find) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 298. 
; 
; Design find?. The function consumes a Dir and a file name and determines 
; whether or not a file with this name occurs in the directory tree. 

(require htdp/dir)

; Dir File -> Boolean
; true if the file is found in the directory structure
(check-expect (find? (make-dir 'Test empty empty) '|King Lear.pdf|) #false)
(check-expect (find? (make-dir 'Test
                               (list (make-dir 'T2 
                                               empty
                                               empty))
                               empty)
                     '|King Lear.pdf|) #false)
(check-expect (find? (make-dir 'Test
                               empty
                               (list (make-file '|King Lear.pdf| 20 "")))
                     '|King Lear.pdf|) #true)
(check-expect (find? (make-dir 'Test
                               (list (make-dir 'T2 
                                               empty
                                               (list
                                                (make-file '|King Lear.pdf|
                                                           20
                                                           ""))))
                               empty)
                     '|King Lear.pdf|) #true)  
(check-expect (find? (make-dir 'Test
                               empty
                               (list 
                                (make-file 'read1 10 "")
                                (make-file '|King Lear.pdf| 20 "")))
                     '|King Lear.pdf|) #true)
                 
(define (find? root file)
  (local (; LOF -> Boolean
          ; true if file is found in the list of files
          (define (found-file? f*)
            (ormap (lambda (f) (eq? file (file-name f))) f*)))
    
    (or (found-file? (dir-files root))
        ; check all sub-directories
        (ormap (lambda (d) (found-file? (dir-files d))) (dir-dirs root)))))
    