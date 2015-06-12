;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-284-Model1-how-many) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 284. 
;
; Design the function how-many, which determines how many files a given Dir.v1
; contains. Remember to follow the design recipe; exercise 283 provides you
; with data examples.

; A Dir.v1 (short for directory) is one of: 
; – '()
; – (cons File.v1 Dir.v1)
; – (cons Dir.v1  Dir.v1)
 
; A File.v1 is a Symbol. 

; Dir.v1 -> Number
; number of files in the directory
(check-expect (how-many '()) 0)
(check-expect (how-many (cons 'read1 '())) 1)
(check-expect (how-many '(read1 (part1 part2 part3))) 4)
(check-expect (how-many '(read1 (part1 part2 part3)
                                ((read1) (hang draw)))) 7)

(define (how-many root)
  (cond [(empty? root) 0]
        [(symbol? (first root))
         (+ 1 (how-many (rest root)))]
        [else (+ (how-many (first root))
                 (how-many (rest  root)))]))