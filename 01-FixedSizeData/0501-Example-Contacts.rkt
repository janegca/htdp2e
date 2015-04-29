;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0501-Example-Contacts) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; define a structure to hold an entry in a contact list
; DrRacket will automatically create the following related functions:
;    make-entry         constructor
;    entry-name         selector
;    entry-phone        selector
;    entry-email        selector
;    entry?             predicate

(define-struct entry [name phone email])
; An Entry is a structure: (make-entry String String String)
; interpretation: name, 7-digit phone number, and email address of a contact

; to create a new entries
(define pl (make-entry "Sarah Lee" "666-7771" "lee@classy-university.edu"))
(define bh (make-entry "Tara Harper" "666-7770" "harper@small-college.edu"))

; using selectors
(entry-name pl)   ; "Sarah Lee"
(entry-name bh)   ; "Tara Harper"

(entry-email pl)  ; "lee@classy-university.edu"
(entry-email bh)  ; "harper@classy-university.edu"

; nested structures
; here, a contact list entry has a name and 3 phone numbers
; we want the phone numbers to have the same structure:
; area code and local number

(define-struct centry [name home office cell]) 
(define-struct phone  [area number]) 

(make-centry "Shriram Fisler"             
             (make-phone 207 "363-2421")            
             (make-phone 101 "776-1099")           
             (make-phone 208 "112-9981"))