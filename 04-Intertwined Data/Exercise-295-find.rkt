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

; Dir Symbol -> Path
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
(check-expect (find f73 'read!) (list 'TS 'read!))
(check-expect (find f73 'draw)  (list 'TS 'Libs 'Code 'draw))
(check-expect (find f73 'part1) (list 'TS 'Text 'part1))

(define (find root file)
  (local (; Dir -> Boolean
          (define (find-in-this-dir d)
            (ormap (lambda (f) (eq? file (file-name f))) (dir-files d)))
          
          ; [List of Dir] -> Path
          (define (find-in-subdirs d*)
            (cond [(empty? d*) '()]
                  [else (append (find (first d*) file)
                                (if (find-in-this-dir (first d*))
                                    '()
                                    (find-in-subdirs (rest d*))))])))
    
    (cond [(find-in-this-dir root)
           (list (dir-name root) file)]
          [(empty? (dir-dirs root)) '()]
          [else (append (list (dir-name root))
                        (find-in-subdirs (dir-dirs root)))])))

; Dir Symbol -> [List-of Path]
; list all paths to the found file
(check-expect (find-all f73 'read!) 
              (list (list 'TS 'read!)
                    (list 'TS 'Libs 'Docs 'read!)))
(check-expect (find-all f73 'hang)  
              (list (list 'TS 'Libs 'Code 'hang)))
(check-expect (find-all f73 'part1) 
              (list (list 'TS 'Text 'part1)))
(check-expect (find-all f73 'test) (list '()))

(define (find-all root file)
  (local (; LOP LOD -> LOP
          ; searches a list of directories for file
          (define (srch-sub-dirs p* d*)
            (cond [(empty? d*) '()]
                  [(found-in-files? (first d*)) 
                     ; append path and continue search
                     (append p* (find (first d*) file))]
                  [else 
                   ; check current node's subdirectories and remaining dirs
                   (append 
                    (srch-sub-dirs 
                     (append p* (list (dir-name (first d*))))
                     (dir-dirs (first d*)))
                    (srch-sub-dirs p* (rest d*)))]))
            
          ; Dir -> LOP
          ; the file path as a list element, if the file is found
          ; otherwise, an empty path
          (define (file-path d)
            (cond [(empty? (dir-files d)) '()]
                  [(found-in-files? d)
                   (list (list (dir-name d) file))]
                  [else '()]))
                    
          ; Dir -> Boolean
          ; returns true if file is found in the directory's list
          ; of files
          (define (found-in-files? d)
            (ormap (lambda (f) (eq? file (file-name f))) (dir-files d))))
    ; -- IN --
    (append (file-path root)
            (if (list? (dir-dirs root)) ; has sub-dirs?
                (list (srch-sub-dirs (list (dir-name root)) ; parent dirs
                                     (dir-dirs root)))
                '()))))

