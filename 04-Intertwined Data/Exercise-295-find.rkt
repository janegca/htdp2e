;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-295-find) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 295. 
; 
; Design find. The function consumes a directory d and a file name f. If 
; (find? d f) is true, find produces a path to a file with name f; otherwise 
; it produces #false.
;
; Hint: While it is tempting to first check whether the file name occurs in 
;       the directory tree, you have to do so for every single subdirectory. 
;       Hence it is better to combine the functionality of find? and find.
;
; Challenge: The find function discovers only one of the two files named
;            read! file in figure 73. Design find-all, which is generalizes 
;            find and produces the list of all paths that lead to f in d. 
;            What should find-all produce when (find? f d) is #false? Is this
;            part of the problem really a challenge compared to the basic 
;            problem?

(require htdp/dir)

; -- Figure 73 as a Model 3 directory structure
(define f73
(make-dir 'TS
             (list (make-dir 'Text
                                '() 
                                (list (make-file 'part1 99 "")
                                      (make-file 'part2 52 "")
                                      (make-file 'part3 17 "")))
                   (make-dir 'Libs 
                                (list (make-dir 'Code 
                                                   '() 
                                                   (list 
                                                    (make-file 'hang 8 "")
                                                    (make-file 'draw 2 "")))
                                      (make-dir 'Docs 
                                                   '() 
                                                   (list
                                                    (make-file 'read! 19 ""))))
                                '()))
             (list (make-file 'read! 10 ""))))

; Path = [List-of Symbol]
; interpretation directions on how to find a file in a directory tree

; Dir File -> Path
; returns the path of the file, if found in the directory structure
(check-expect (find (make-dir 'T empty empty) 'read!) '())
(check-expect (find (make-dir 'T 
                              empty 
                              (list (make-file 'read! 10 ""))) 
                    'read!)
                    (list 'T 'read!))
(check-expect (find (make-dir 'T
                              (list (make-dir 'T1 
                                        empty
                                        (list (make-file 'read! 10 ""))))
                              empty)
                    'read!)
              (list 'T 'T1 'read!))

(define (find root file)
  (local (          
          (define (find-in-this-dir d)
            (ormap (lambda (f) (eq? file (file-name f))) (dir-files d)))
          
          (define (find-in-subdirs d*)
            (cond [(empty? d*) '()]
                  [(find-in-this-dir (first d*))
                   (append (list (dir-name (first d*)) file)
                           (find-in-subdirs (rest d*)))]
                  [else (append (list (dir-name (first d*)))
                                (find-in-subdirs (rest d*)))])))
    
    (append (if (find-in-this-dir root)
                (list (dir-name root) file)
                '())
            (find-in-subdirs (dir-dirs root)))))

; NOT RIGHT YET

