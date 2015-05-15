;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 1104-Example-GraphicalEditorRevisited) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; 11.04 - Example - Graphical Editor Revisted
;
; Revisits the design of the structure used for the Editor
; The String editor-pre can be kept in normal or reverse order
; keeping it in reverse order simplifies

(define-struct editor [pre post])
; An Editor is (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – empty 
; – (cons 1String Lo1S) 

(define good  (cons "g" (cons "o" (cons "o" (cons "d" '())))))
(define all   (cons "a" (cons "l" (cons "l" '()))))
(define lla   (cons "l" (cons "l" (cons "a" '()))))

; data example 1:
(make-editor all good) 

; data example 2:
(make-editor lla good)

; Lo1s -> Lo1s 
; produces a reverse version of the given list 
(check-expect  (rev (cons "a" (cons "b" (cons "c" '())))) 
               (cons "c" (cons "b" (cons "a" '())))) 

(define (rev l) 
  (cond    [(empty? l) '()]   
           [else (add-at-end (rev (rest l)) (first l))]))

; Lo1s 1String -> Lo1s
; creates a new list by adding s to the end of l
(check-expect (add-at-end '() "a")
              (cons "a" '()))
(check-expect 
 (add-at-end (cons "c" (cons "b" '())) "a") 
 (cons "c" (cons "b" (cons "a" '()))))

(define (add-at-end l s) 
  (cond    [(empty? l) (cons s '())]  
           [else (cons (first l) (add-at-end (rest l) s))]))








