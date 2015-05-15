;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 1104-Example-GraphicalEditorRevV2) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; 11.04 - Example - Graphical Editor Revisted
;
; Establish functions, and their related check-expects, for use with 
; theEditor structure; completing editor-ins
;
; [Note: the design calls for the Editor's 'pre' string to
;        be kept in reverse order]

; constants 
(define HEIGHT 20)          ; the height of the editor 
(define WIDTH 200)          ; its width 
(define FONT-SIZE 16)       ; the font size 
(define FONT-COLOR "black") ; the font color 

; graphical constants 
(define MT (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))

; -- data structure
(define-struct editor [pre post])
; An Editor is (make-editor Lo1S Lo1S) 
; An Lo1S is one of: 
; – empty 
; – (cons 1String Lo1S) 
; interpretation: (make-editor pre post) implicitly combines the
; position of a cursor (between the pre and post strings) while
; maintaining the 'pre' Lo1S in reverse order and the the 'post' Lo1S 
; in normal order.

; -- Functions

; String String -> Editor
; combines two string to create an Editor
(check-expect (create-editor "all" "good")
              (make-editor (cons "l" (cons "l" (cons "a" '())))
                           (cons "g" (cons "o" (cons "o" (cons "d" '()))))))
              
(define (create-editor s1 s2)
  (make-editor (reverse (explode s1)) (explode s2)))


; Editor -> Image
; renders an editor as an image of the two texts separated by the cursor
(define (editor-render e)  MT) 

; Editor KeyEvent -> Editor
; deals with a key event, given some editor
(check-expect (editor-kh (create-editor "" "") "e")  
              (create-editor "e" ""))
(check-expect (editor-kh (create-editor "cd" "fgh") "e") 
              (create-editor "cde" "fgh"))
(check-expect (editor-kh (create-editor "" "") "left")
              (create-editor "" ""))
(check-expect (editor-kh (create-editor "cde" "fgh") "left")
              (create-editor "cd" "efgh"))
(check-expect (editor-kh (create-editor "cde" "fgh") "right")
              (create-editor "cdef" "gh"))
(check-expect (editor-kh (create-editor "" "cde") "\b")
              (create-editor "" "cde"))
(check-expect (editor-kh (create-editor "cde" "fgh") "\b")
              (create-editor "cd" "fgh"))
(check-expect (editor-kh (create-editor "cde" "fgh") "\t")
              (create-editor "cde" "fgh"))
(check-expect (editor-kh (create-editor "cde" "fgh") "\r")
              (create-editor "cde" "fgh"))
(check-expect (editor-kh (create-editor "ab" "c") "next")
              (create-editor "ab" "c"))
             
(define (editor-kh ed k)  
  (cond   
    [(key=? k "left")  (editor-lft ed)] 
    [(key=? k "right") (editor-rgt ed)] 
    [(key=? k "\b")    (editor-del ed)]  
    [(key=? k "\t")    ed]                
    [(key=? k "\r")    ed]   
    [(= (string-length k) 1) (editor-ins ed k)]  
    [else ed]))

; Editor -> Editor
; move the cursor one place to the left, if possible
(define (editor-lft ed) ed)

; Editor -> Editor
; move the cursor one place to the right, if possible
(define (editor-rgt ed) ed)

; Editor -> Editor
; delete the character one space to the left of the cursor
; if possible
(define (editor-del ed) ed)

; Editor 1String -> Editor
; insert the 1String k between pre and post
(check-expect  (editor-ins (make-editor '() '()) "e") 
               (make-editor (cons "e" '()) '()))
(check-expect  (editor-ins (make-editor (cons "d" '())       
                                        (cons "f" (cons "g" '())))        
                           "e")  
               (make-editor (cons "e" (cons "d" '()))           
                            (cons "f" (cons "g" '()))))

(define (editor-ins ed k)  
  (make-editor (cons k (editor-pre ed)) (editor-post ed)))


; main : String -> Editor
; launches the editor given some initial string
(define (main s)  
  (big-bang (create-editor s "")      
            (on-key        editor-kh)         
            (to-draw       editor-render)))







