;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-073-EditorV3) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 73. 
;
; Notice that if you type a lot, your editor program does not display all 
; of the text. Instead the text is cut off at the right margin. Modify your 
; function edit from exercise 71 so that it ignores a keystroke if adding it 
; to the end of the pre field would mean the rendered text is too wide for 
; your canvas. 

(define-struct editor [pre post])
; Editor = (make-editor String String)
; interpretation (make-editor s t) means the text in the editor is
; (string-append s t) with the cursor displayed between s and t

; Physical constants
(define WIDTH      200)
(define HEIGHT      20)
(define YCENTER    (/ HEIGHT 2))
(define FONT-SIZE  16)
(define FONT-COLOR "black")

; Graphic constants
(define FIELD  (empty-scene WIDTH HEIGHT))
(define CURSOR (rectangle 1 HEIGHT "solid" "red"))

; Functions

; Editor -> Image
; returns the editor text as an image with the cursor
; appropriately placed
(check-expect (render (make-editor "hello " "world"))
              (overlay/align "left" "center"
                             (beside (text "hello " FONT-SIZE FONT-COLOR)
                                     CURSOR
                                     (text "world" FONT-SIZE FONT-COLOR))
                             FIELD))
              
(define (render e) 
  (place-image/align 
   (beside (text (editor-pre e) FONT-SIZE FONT-COLOR)
           CURSOR
           (text (editor-post e) FONT-SIZE FONT-COLOR))
   0 YCENTER "left" "center" FIELD))

; Editor KeyEvent -> Editor
; modifies the contents of the editor based on the given key event
(check-expect (edit (make-editor "hel" "lo") "left")
              (make-editor "he" "llo"))
(check-expect (edit (make-editor "hel" "lo") "right")
              (make-editor "hell" "o"))
(check-expect (edit (make-editor "hel" "o") "l")
              (make-editor "hell" "o"))
(check-expect (edit (make-editor "hello" "world") "up")
              (make-editor "hello" "world"))
(check-expect (edit (make-editor "tomorrow is another day, " "not!") "a")
              (make-editor "tomorrow is another day, " "not!"))

(define (edit ed ke) 
  (cond
    [(string=? ke "left")     (move-left  ed)]     ; left-arrow key event
    [(string=? ke "right")    (move-right ed)]     ; right-arrow key event
    [(= (string-length ke) 1) 
     (if (lengthOK ed) (process-key ed ke) ed)] ; single character key event
    [else ed]))                                    ; ignore other key events

; Editor -> Boolean
; returns true if adding a character will not exceed field width
(define (lengthOK ed)
  (> WIDTH
     (image-width (text (string-append (editor-pre ed) (editor-post ed) "  ")
                        FONT-SIZE FONT-COLOR))))
    

; Editor -> Editor
; move the cursor one letter to the left, if possible
(check-expect (move-left (make-editor "hello" ""))
                         (make-editor "hell" "o"))
(check-expect (move-left (make-editor "" "hello"))
              (make-editor "" "hello"))

              
(define (move-left ed) 
  (cond
    [(string=? "" (editor-pre ed)) ed]
    [ else (make-editor (string-remove-last (editor-pre ed)) 
                        (string-append (string-last (editor-pre ed)) 
                                       (editor-post ed)))]))

; Editor -> Editor
; move the cursor one letter to the right, if possible
(check-expect (move-right (make-editor "hello" ""))
              (make-editor "hello" ""))
(check-expect (move-right (make-editor "hell" "o"))
              (make-editor "hello" ""))
(check-expect (move-right (make-editor "hello" "world"))
              (make-editor "hellow" "orld"))

(define (move-right ed)
  (cond
    [(string=? "" (editor-post ed)) ed]
    [else (make-editor (string-append (editor-pre ed) 
                                      (string-first (editor-post ed)))
                       (string-rest (editor-post ed)))]))

; Editor KeyEvent -> Editor
; delete one letter to the left if backspace key event,
; otherwise append the character
(check-expect (process-key (make-editor "hell" "o") "\b")
              (make-editor "hel" "o"))
(check-expect (process-key (make-editor "hell" "o") "\t")
              (make-editor "hell" "o"))
(check-expect (process-key (make-editor "hell" "o") "\r")
              (make-editor "hell" "o"))
(check-expect (process-key (make-editor "hell" "o")  "\u007F")
              (make-editor "hell" "o"))              
(check-expect (process-key (make-editor "hell" "o") "up")
              (make-editor "hell" "o"))
(check-expect (process-key (make-editor "hello wo" "") "r")
              (make-editor "hello wor" ""))
(check-expect (process-key (make-editor "hell" "world") "o")
              (make-editor "hello" "world"))

(define (process-key ed ke) 
  (cond
    [(string=? "\b" ke)     (backspace ed)]
    [(or (string=? "\t" ke) 
         (string=? "\r" ke)
         (string=? "\u007F" ke)) ed]  ; tab, return and delete keys
    [(> (string-length ke) 1) ed]
    [else 
     (make-editor (string-append (editor-pre ed) ke)
                                 (editor-post ed))]))

; Editor -> Editor
; delete a character at the cursor position, if one exists
(check-expect (backspace (make-editor "hell" "o"))
              (make-editor  "hel" "o"))
(check-expect (backspace (make-editor "" "hello"))
              (make-editor "" "hello"))

(define (backspace ed)
  (cond
   [(string=? "" (editor-pre ed)) ed]
   [ else  (make-editor (string-remove-last (editor-pre ed))
                        (editor-post ed))]))
   
; String -> String
; returns the first character from a non-empty string.
(check-expect (string-first "hello") "h")

(define (string-first str)
  (string-ith str 0))

; String -> String
; returns the last character from a non-empty string
(check-expect (string-last "hello") "o")

(define (string-last str)
  (string-ith str (- (string-length str) 1)))

; String -> String
; return all but the first letter in the given string
(check-expect (string-rest "hello") "ello")

(define (string-rest str)
  (substring str 1 (string-length str)))

; String -> String
; return all but the last character of the given string
(check-expect (string-remove-last "hello") "hell")

(define (string-remove-last str) 
  (substring str 0 (- (string-length str) 1)))

; String -> Editor
; accepts a string and starts an editor
(define (run s)
  (main (make-editor s "")))

; Editor -> Editor
; starts an editor
(define (main eds)
  (big-bang eds
            [to-draw render]
            [on-key  edit]))



