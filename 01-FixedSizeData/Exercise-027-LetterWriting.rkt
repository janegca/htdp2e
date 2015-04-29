;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-027-LetterWriting) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 27. 
; Recall the letter program from Composing Functions.
; Below is a letter-writing batch program that reads names from three files 
; and writes a letter to one.
;
; The function consumes four strings: the first three are the names of input
;files and the last one serves as output file. It uses the first three to read
; one string each from the three named files, hands these strings to letter,
; and eventually writes the result of this function call into the file named 
; by out, the fourth argument to main.
;
; Create appropriate files, launch main, and check whether it delivers the 
; expected letter.


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

(define (main in-fst in-lst in-signature out)  
  (write-file out             
             (letter (read-file in-fst)                     
                     (read-file in-lst)                     
                     (read-file in-signature))))

; write the three files
(write-file "fst.dat" "Matthew")
(write-file "lst.dat" "Fisler")
(write-file "sig.dat" "Felleisen")

; create the required letter
(main "fst.dat" "lst.dat" "sig.dat" 'stdout)




