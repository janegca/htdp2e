;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-293-computeStorageSpace) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 294. 
; 
; Design du, a function that consumes a Dir and computes the total size of
; all the files in the entire directory tree. Assume that storing a 
; directory in a Dir structure costs 1 file storage unit. In the real world, 
; a directory is basically a special file and its size depends on how large 
; its associated directory is. 

(require htdp/dir)

; Dir -> Number
; the storage space being consumed by the given directory structure
(check-expect (du (make-dir 'T '() '())) 1)
(check-expect (du (make-dir 'T '() (list (make-file 'f1 20 "")
                                         (make-file 'f2 20 ""))))
              41)
(check-expect (du (make-dir 'T  
                            (list (make-dir 'T1
                                            empty
                                            (list (make-file 'f1 20 "")
                                                  (make-file 'f2 20 ""))))
                            (list (make-file 'f3 40 ""))))
              82)
(check-expect 
 (du (make-dir 'T
               (list (make-dir 'T1
                               (list (make-dir 'T2 
                                               empty
                                               (list (make-file 'f1 20 ""))))
                               empty))
               (list (make-file 'f2 20 ""))))
     43)
                                            
(define (du root)
  (local (; LOF -> Number
          ; total of the file sizes in the given list
          (define (file-storage f*)
            (foldr + 0 (map file-size f*))))
  (+ 1 
     (cond [(empty? (dir-dirs root)) 
            (file-storage (dir-files root))]
           [else 
            (+ (file-storage (dir-files root))
               (foldr + 0 (map (lambda (d) (du d)) (dir-dirs root))))]))))

