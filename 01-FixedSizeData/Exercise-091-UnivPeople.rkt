;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-091-UnivPeople) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 91. 
;
; Develop a data representation for the kinds of people you find at a 
; university: student (first and last name, gpa), professor (first and 
; last name, tenure status), and staff (first and last name, salary group).
; Then develop a template for functions that consume the representation of a 
; person. 

(define-struct name [first last])
; is (make-name String String)
; interpreation: the first and last name of an individual person
;
;  ( ... (name-first n) ... (name-last n) ... )

(define-struct student [name gpa])
; is (make-student Name Number)
; interpretation: the students name and gpa
;
;  ( ... (student-name s) ... (student-gpa s) ... )

(define-struct professor [name tenure])
; is (make-professor Name String)
; interpretation: a sprofessors name and tenure status
;
;  ( ... (professor-name p) ... (professor-tenure p) ... )

(define-struct staff [name group])
; is (make-staff Name String)
; interpretation: a staff person's name and salary group
;
;   ( ... (staff-name s) ... (staff-group s) ... )

