;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-297-find-all-revisited) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 297. 
; 
; Re-design find-all from exercise 295 using ls from exercise 296. This is
; design by composition, and if you solved the challenge part of exercise 
; 296 your new function can find directories, too.
;
; NOTE: if searching for a directory, paths to all the found directory's
;       contents are returned

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

; -- ls-R from Exercise 296

; Dir -> LLOP
; a list of all file paths in the directory structure
(define (ls-R root)
  (local (; Dir LLOP -> LLOP
          ; a list of filepaths for all directories and files
          ; in the directory structure
          (define (process-dir parents d)
            (append (bld-path parents d)
                    (if (list? (dir-dirs d))
                        (process-sub-dirs (append parents (list (dir-name d))) 
                                          (dir-dirs d))
                        '())))
          
          ; LOD -> LLOP
          ; a list of full filepaths for every directory and file found
          ; in each directory in the given list of directories
          (define (process-sub-dirs parents d*)
            (cond [(empty? d*) '()]
                  [else (append (process-dir      parents (first d*))
                                (process-sub-dirs parents (rest d*)))]))
          
          ; Dir -> LLOP
          ; return a list of full filepaths for each file in the directory,
          ; including the full path to the given directory
          (define (bld-path parents d)
            (local ((define cp     (list (dir-name d))) ; current dir
                    (define fp     (append parents cp)) ; full dir path
                    (define files  (dir-files d)))      ; all fiels in dir
              (append (list fp)
                      (map (lambda (f) (append fp (list (file-name f))))
                           files)))))
    ;-- IN --
    (process-dir '() root)))

; Dir Symbol -> LLOP
; the paths to file in the directory structure
(check-expect (find-all 'read! f73)
              (list (list 'TS 'read!)
                    (list 'TS 'Libs 'Docs 'read!)))
(check-expect (find-all 'Code f73)
              (list (list 'TS 'Libs 'Code)
                    (list 'TS 'Libs 'Code 'hang)
                    (list 'TS 'Libs 'Code 'draw)))
              
(define (find-all sym root)
  (local ((define paths (ls-R root))
          (define (srch-paths p*)
            (cond [(empty? p*) '()]
                  [(member? sym (first p*))
                   (append (list (first p*))
                           (srch-paths (rest p*)))]
                  [else (srch-paths (rest p*))])))
    ; -- IN --
    (srch-paths paths)))

    
          
    