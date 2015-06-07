;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-247-UsingFiltersWithLambdas) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 247
;
; Re-write Exercise 234 using lambda's vs local functions

(define-struct ir [name desc ap sp])
; An IR is a (make-ir String String Number Number)
; interpretation: (make-ir name desc ap sp) combines the elements of
; an inventory item into a record representing the items name,
; description (desc), acquisition price (ap) and sales price (sp).

; Number [List-of IR] -> [List-of IR]
; returns a list of inventory items whose sale price is below the
; given number (ua)
(check-expect (eliminate-exp 2 '()) '())
(check-member-of (eliminate-exp 5 (list (make-ir "item 1" "desc 1"  25  30)
                                        (make-ir "item 2" "desc 2" 120 140)
                                        (make-ir "item 3" "desc 3"   .5  .5)
                                        (make-ir "item 4" "desc 4"   1   4)))
              (list (make-ir "item 2" "desc 2" 120 140)
                    (make-ir "item 1" "desc 1"  25  30))
              (list (make-ir "item 1" "desc 1"  25  30)
                    (make-ir "item 2" "desc 2" 120 140)))

(define (eliminate-exp ua loir)
    (filter (lambda (a) (> (ir-sp a) ua))
            loir))

; String [List-of IR] -> [List-of IR]
; returns a list of inventory items whose name does not include the given
; string (ty)
(check-expect (recall "robot" '()) '())
(check-member-of (recall "robot" 
                      (list (make-ir "robot"        "d1" 1 2)
                            (make-ir "rocket"       "d2" 2 3)
                            (make-ir "ufo"          "d3" 4 5)
                            (make-ir "rockin-robot" "d4" 2 2)))
              (list (make-ir "rocket" "d2" 2 3)
                    (make-ir "ufo"    "d3" 4 5))
              (list (make-ir "ufo"    "d3" 4 5)
                    (make-ir "rocket" "d2" 2 3)))

(define (recall ty loir)
    (filter (lambda (str) 
              (not (string-contains? ty (ir-name str))))
            loir))

; [List-of String] [List-of String] -> [List-of String]
; returns a list of names from the second list of strings which also
; appear in the first list of strings
(check-expect (selection (list "John" "Paul") '())   '())
(check-expect (selection '() (list "George" "John")) '())
(check-expect (selection (list "John" "Paul" "Ringo" "Sam")
                         (list "Paul" "George" "Ringo"))
              (list "Paul" "Ringo"))

(define (selection los1 los2)
    (filter (lambda (str) (member? str los2))
            los1))