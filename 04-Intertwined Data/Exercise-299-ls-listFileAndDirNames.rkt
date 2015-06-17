;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-293-listFileAndDirNames) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 299. 
;
; Design the function ls, which lists the names of all files and directories 
; in a given Dir.

(require htdp/dir)

; Dir -> [List-of LOD]
(check-expect (ls (make-dir 'Test empty empty)) '(Test))
(check-expect (ls (make-dir 'T
                            empty
                            (list (make-file 'f1 1 "")
                                  (make-file 'f2 2 ""))))
              '(T f1 f2))
(check-expect (ls (make-dir 'T
                            (list (make-dir 'T1
                                            empty
                                            (list (make-file 'f3 3 ""))))
                            empty))
              '(T (T1 f3)))

(define (ls root)
  (append (list (dir-name root))
          (cond [(empty? (dir-dirs root))
                 (map file-name (dir-files root))]
                [else (map (lambda (d) (ls d)) (dir-dirs root))])))
