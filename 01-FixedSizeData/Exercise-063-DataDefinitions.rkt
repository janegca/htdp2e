;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-063-DataDefinitions) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 63. 
; Formulate data definitions for the following structure type 
; definitions (Make sensible assumptions as to what kind of values go into 
; each field):
(define-struct movie [title producer year])
; A Movie is a structure: (make-movie String String Number)
; interpretation: (make-movie title producer year) is the name of the movie,
; the name of the movie's producer and the year of its release

(define-struct boyfriend [name hair eyes phone])
; A Boyfriend is a structure: (make-boyfriend String String String String)
; interpretation: (make-boyfriend name hair eyes phone) is the boyfriend's
; name, hair colour, eye colour and phone number.

(define-struct cheerleader [name number])
; A Cheerleader is a structure: (make-cheerleader String Number)
; interpretation: (make-cheerleader name number) is the name of the cheerleader
; and the number on their unifrom

(define-struct CD [artist title price])
; A CD is a structure: (make-CD String String Number)
; interpretation: (make-CD artist title price) is the name of the recording
; artist, the CD title and the retail price of the CD

(define-struct sweater [material size producer])
; A Sweater is a structure: (make-sweater String Number String)
; interpretation: (make-sweater material size producer)  is the material
; from which the sweater is made, the sweater size and the person who
; made the sweater.


