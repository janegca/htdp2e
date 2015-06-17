;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-296-ls-R) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 302. 
;
; Design the function ls-R, which lists the paths to all files in a given Dir. 
; Challenge: Modify ls-R so that its result includes all paths to directories,
;            too.

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

; Dir -> LLOP
; a list of all file paths in the directory structure
(check-expect (ls-R (make-dir 'TS empty empty)) (list (list 'TS)))
(check-expect (ls-R (make-dir 'TS 
                              '() 
                              (list (make-file 'read! 10 ""))))
              (list (list 'TS) (list 'TS 'read!)))
(check-expect (ls-R (make-dir 'TS 
                              (list (make-dir 'Text 
                                              '()
                                              (list (make-file 'part1 99 "")
                                                    (make-file 'part2 52 "")
                                                    (make-file 'part3 17 ""))))
                              '()))
              (list (list 'TS)
                    (list 'TS 'Text)
                    (list 'TS 'Text 'part1)
                    (list 'TS 'Text 'part2)
                    (list 'TS 'Text 'part3)))

(check-expect (ls-R f73)
              (list
               (list 'TS)
               (list 'TS 'read!)
               (list 'TS 'Text)
               (list 'TS 'Text 'part1)
               (list 'TS 'Text 'part2)
               (list 'TS 'Text 'part3)
               (list 'TS 'Libs)
               (list 'TS 'Libs 'Code)
               (list 'TS 'Libs 'Code 'hang)
               (list 'TS 'Libs 'Code 'draw)
               (list 'TS 'Libs 'Docs)
               (list 'TS 'Libs 'Docs 'read!)))

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
