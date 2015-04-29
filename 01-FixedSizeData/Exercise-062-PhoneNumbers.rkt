;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-062-PhoneNumbers) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 62. 
;
; Formulate a data definition for the above phone structure type definition 
; that accommodates the given example: (make-phone 207 "363-2421")            
;
; Next formulate a data definition for phone numbers using this structure type
; definition:
;
;    (define-struct phone# [area switch phone])
;
; Historically, the first three digits make up the area code, the next three 
; the code for the phone switch (exchange) of your neighborhood, and the last 
; four represent the phone with respect to the neighborhood. Describe the 
; content of the three fields as precisely as possible with intervals. 

(define-struct phone [area number])
; A Phone is a structure: (make-phone Number String)
; interpretation:  a 3 digit area code and a 7-digit phone number

(define-struct phone# [area switch phone])
; A Phone# is a structure: (make-phone Number Number Number)
; interpretation:
;      area is a number between 000  and 999
;    switch is a number between 000  and 999
;     phone is a number between 0000 and 9999

