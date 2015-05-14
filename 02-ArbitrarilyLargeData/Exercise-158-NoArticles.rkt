;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-158-NoArticles) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 158. 
; 
; Design a program that removes all articles from a text file. The program 
; consumes the name n of a file, reads the file, removes the articles, and
; writes the result out to a file whose name is the result of concatenating 
; "no-articles-" with n. For this exercise, an article is one of the following
; three words: "a", "an", and "the".
;
; Use read-words/line so that the transformation retains the organization of 
; the original text into lines and words. When the program is designed, run 
; it on the Piet Hein poem. 

; File -> File
; reads the given file, removing all articles (a, an, the) and
; writes out the result to 'no-arcticles-[original file name]'

(define (no-articles fn)
  (write-file (string-append "no-articles-" fn)
              (remove-articles-from-lls (read-words/line fn))))

; LLS -> LLS
; remove the articles "a", "an", "the" from all strings in the given LLS
(define los1 (cons "the"(cons "man"(cons "in" (cons "the" (cons "moon" '()))))))
(define los2 (cons "a"(cons "cat" '())))
(define los3 (cons "an" '()))

(define lls1 (cons los1 (cons los2 (cons los3 '()))))

(define los4 (cons "man" (cons "in" (cons "moon" '()))))
(define los5 (cons "cat" '()))

(check-expect (remove-articles-from-lls lls1)
              "man in moon \ncat \n\n")
                    
(define (remove-articles-from-lls lls) 
  (cond [(empty? lls) ""]
        [(cons?  lls)
         (string-append (remove-articles-from-los (first lls)) "\n"
                        (cond [(empty? (rest lls)) ""]
                              [else (remove-articles-from-lls (rest lls))]))]))
         
; LOS -> LOS
; remove the articles "a", "an", "the" from a list of strings
(check-expect (remove-articles-from-los 
               (cons "a"(cons "bad" (cons "apple" '()))))
              "bad apple ")

(define (remove-articles-from-los los)
  (cond [(empty? los) ""]
        [(cons?  los)
         (cond [(is-article? (first los)) 
                (remove-articles-from-los (rest los))]
               [else (string-append (first los) " "
                           (remove-articles-from-los (rest los)))])]))

; String -> Boolean
; return true if the string is one of "a", "an" or "the"
(check-expect (is-article? "a")   true)
(check-expect (is-article? "an")  true)
(check-expect (is-article? "the") true)
(check-expect (is-article? "yes") false)
              
(define (is-article? str)
  (or (string=? "a"   str)
      (string=? "an"  str)
      (string=? "the" str)))

