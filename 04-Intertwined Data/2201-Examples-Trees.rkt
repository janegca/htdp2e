;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 2201-Examples-Trees) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 22.1 Trees - Examples

; An example of a data structure to model a family tree

(define-struct no-parent [])
(define-struct child [father mother name date eyes])

(define MTFT (make-no-parent))

; A FT (family tree) is one of:
; - MTFT
; - (make-child FT FT String N String)

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

; --Designing a generic function for family trees

; a template

; FT -> ???
(define (fun-for-FT a-ftree)
  (cond
    [(no-parent? a-ftree) ...]
    [else
      (... (fun-for-FT (child-father a-ftree)) ...
       ... (fun-for-FT (child-mother a-ftree)) ...
       ... (child-name a-ftree) ...
       ... (child-date a-ftree) ...
       ... (child-eyes a-ftree) ...)]))

; a concrete example
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

