;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 2202-SP-Forests) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 22.02 - Sample Problem - Forests

; Sample Problem:
; 
; Design the function blue-eyed-child-in-forest?, which determines whether a
; family forest contains a child with "blue" in the eyes field.

; -- data structures
(define-struct no-parent [])
(define-struct child [father mother name date eyes])

(define MTFT (make-no-parent))

; A FF (family forest) is one of: 
; – '()
; – (cons FT FF)

; -- example family tree

; oldest generation
(define Carl    (make-child MTFT MTFT "Carl" 1926 "green"))
(define Bettina (make-child MTFT MTFT "Bettina" 1925 "green"))

; middle generation
(define Adam (make-child Carl Bettina "Adam" 1950 "hazel"))
(define Dave (make-child Carl Bettina "Dave" 1955 "black"))
(define Eva  (make-child Carl Bettina "Eva" 1965 "blue"))
(define Fred (make-child MTFT MTFT "Fred" 1966 "pink"))

; youngest generation
(define Gustav (make-child Fred Eva "Gustav" 1988 "brown"))

; -- example forests
(define ff1 (list Carl Bettina))  ; two unrelated families
(define ff2 (list Fred Eva))      ; two unrelared families
(define ff3 (list Fred Eva Carl)) ; overlapping families

; -- Functions 

; FT -> Boolean
; does a-ftree contain a child
; structure with "blue" in the eyes field
; i.e. does ANY node in the given family tree have blue eyes
 
(check-expect (blue-eyed-child? Carl)   #false)
(check-expect (blue-eyed-child? Gustav) #true)
(check-expect (blue-eyed-child? Eva)    #true)
 
(define (blue-eyed-child? a-ftree)
  (cond
    [(no-parent? a-ftree) #false]
    [else (or (string=? (child-eyes a-ftree) "blue")
              (blue-eyed-child? (child-father a-ftree))
              (blue-eyed-child? (child-mother a-ftree)))]))

; FF -> Boolean
; does the forest contain any child node with "blue" eyes
 
(check-expect (blue-eyed-child-in-forest? ff1) #false)
(check-expect (blue-eyed-child-in-forest? ff2) #true)
(check-expect (blue-eyed-child-in-forest? ff3) #true)
 
(define (blue-eyed-child-in-forest? a-forest)
  (cond
    [(empty? a-forest) #false]
    [else (or (blue-eyed-child?           (first a-forest))
              (blue-eyed-child-in-forest? (rest a-forest)))]))

