;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-162-Editor) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 162. 
;
; Design the function create-editor. The function consumes two strings
; and produces an Editor. The first string is the text to the left of the 
; cursor and the second string is the text to the right of the cursor. 
;
; [Note: the 'pre' Lo1S is maintained in reverse order as it
;        "greatly simplifies the design of the program".]

(define-struct editor [pre post])
; An Editor is (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – empty 
; – (cons 1String Lo1S) 

; String String -> Editor
; combines two string to create an Editor
(check-expect (create-editor "" "")
              (make-editor '() '()))
(check-expect (create-editor "all" "good")
              (make-editor (cons "l" (cons "l" (cons "a" '())))
                           (cons "g" (cons "o" (cons "o" (cons "d" '()))))))
              
(define (create-editor s1 s2)
  (make-editor (reverse (explode s1)) (explode s2)))

(define ex1 (create-editor "abc" "def"))
(define ex2 (create-editor "" "def"))
(define ex3 (create-editor "c" "def"))



