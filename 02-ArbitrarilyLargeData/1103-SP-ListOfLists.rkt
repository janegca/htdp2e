;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 11.03-SP-ListOfLists) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; 11.3 - Sample Problem - List of lists

; A LLS is one of: 
; – '()
; – (cons Los LLS)
; interpretation a list of lines, each line is a list of strings

(define line0 (cons "hello" (cons "world" '())))
(define line1 '()) 

(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))

; LLS -> List-of-numbers
; determines the number of words on each line 
(check-expect (words-on-line lls0) '())
(check-expect (words-on-line lls1) (cons 2 (cons 0 '())))

(define (words-on-line lls) 
  (cond    [(empty? lls) '()] 
           [else (cons (length (first lls))     
                       (words-on-line (rest lls)))]))

; String -> List-of-numbers
; counts the number of words on each line in the given file
(define (file-statistic file-name)  
  (words-on-line   
   (read-words/line file-name)))

(file-statistic "ttt.txt")







