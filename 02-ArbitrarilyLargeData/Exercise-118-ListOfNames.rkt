;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-118-ListOfNames) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 118. 
; Create an element of List-of-names that contains five Strings. 

; A List-of-names is one of: 
; – '()
; – (cons String List-of-names)
; interpretation a List-of-names represents a list of invitees by last name

(cons "Beatles"
      (cons "Lennon"
            (cons "McCartney"
                  (cons "Starr"
                        (cons "Harrison"
                              (cons "Epstein"
                                    '()))))))


