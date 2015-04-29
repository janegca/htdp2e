;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0202-Example-LetterTemplate) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Letter template example

; main function
(define (letter fst lst signature-name) 
  (string-append  
   (opening fst) "\n\n" (body fst lst) "\n\n"  (closing signature-name)))

; helper (auxilary) functions
(define (opening fst)  (string-append "Dear " fst ","))

(define (body fst lst)  
  (string-append   
   "We have discovered that all people with the last name " "\n" lst
   " have won our lottery. So, " fst ", " "\n"  
   "hurry and pick up your prize."))

(define (closing signature-name)  
  (string-append   "Sincerely,"   "\n\n"   signature-name))

; usage example
; (write-file 'stdout (letter "Matthew" "Fisler" "Felleisen"))
