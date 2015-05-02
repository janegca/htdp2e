;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-074-EditorReworked) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 74.
; Develop a data representation based on our first idea, using a string and 
; an index. Then solve exercises exercise 70 through exercise 73 again.

(define-struct editor [txt idx])
; Editor = (make-editor String Number)
; interpretation: (make-editor txt idx) means the text in the editor
; is displayed with a cursor positioned at the given index

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
(check-expect (render (make-editor "hello world" 6))
              (overlay/align "left" "center"
                             (beside (text "hello " FONT-SIZE FONT-COLOR)
                                     CURSOR
                                     (text "world" FONT-SIZE FONT-COLOR))
                             FIELD))

(define (render e) 
  (place-image/align 
   (beside (pre-txt e)
           CURSOR
           (post-txt e))
   0 YCENTER "left" "center" FIELD))

; Editor KeyEvent -> Editor
; modifies the contents of the editor based on the given key event
(check-expect (edit (make-editor "hello" 3) "left")
              (make-editor "hello" 2))
(check-expect (edit (make-editor "hello" 3) "right")
              (make-editor "hello" 4))
(check-expect (edit (make-editor "tomorrow is another day, not!" 5) "a")
              (make-editor "tomorrow is another day, not!" 5))
(check-expect (edit (make-editor "hello" 5) "!")
              (make-editor "hello!" 6))

(define (edit ed ke) 
  (cond
    [(string=? ke "left")     (move-left  ed)]     ; left-arrow key event
    [(string=? ke "right")    (move-right ed)]     ; right-arrow key event
    [(= (string-length ke) 1) 
     (if (lengthOK ed) (process-key ed ke) ed)] ; single character key event
    [else ed]))  

; Editor -> Editor
; move the cursor one character to the left, if possible
(check-expect (move-left (make-editor "hello" 0))
              (make-editor "hello" 0))
(check-expect (move-left (make-editor "hello" 3))
              (make-editor "hello" 2))
              
(define (move-left ed) 
  (if  (= (editor-idx ed) 0)
        ed
       (make-editor (editor-txt ed) (- (editor-idx ed) 1))))

; Editor -> Editor
; move the cursor one character to the right, if possible
(check-expect (move-right (make-editor "hello" 4))
              (make-editor "hello" 5))
(check-expect (move-right (make-editor "hello" 3))
              (make-editor "hello" 4))

(define (move-right ed) 
  (if (< (editor-idx ed) (string-length (editor-txt ed)))
      (make-editor (editor-txt ed) (+ (editor-idx ed) 1))
      ed))

; Editor KeyEvent -> Editor
; delete one letter to the left if backspace key event,
; otherwise append the character
(check-expect (process-key (make-editor "helllo" 3) "\b")
              (make-editor "hello" 2))
(check-expect (process-key (make-editor "hello" 3)  "\u007F")
              (make-editor "hello" 3))
(check-expect (process-key (make-editor "hello" 3) "\t")
              (make-editor "hello" 3))
(check-expect (process-key (make-editor "hello" 3) "\r")
              (make-editor "hello" 3))
(check-expect (process-key (make-editor "hello" 3) "up")
              (make-editor "hello" 3))
(check-expect (process-key (make-editor "helo" 3) "l")
              (make-editor "hello" 4))

(define (process-key ed ke) 
  (cond
    [(string=? "\b" ke)     (backspace ed)]
    [(or (string=? "\t" ke)
         (string=? "\r" ke)
         (string=? "\u007F" ke)) ed] ; tab, return and delete keys
    [(> (string-length ke) 1) ed]
    [else
     (make-editor (string-append 
                   (substring (editor-txt ed) 0 (editor-idx ed))
                   ke 
                   (substring (editor-txt ed) (editor-idx ed)
                              (string-length (editor-txt ed))))
                  (+ 1 (editor-idx ed)))]))

; Editor -> Editor
(check-expect (backspace (make-editor "hello" 3))
              (make-editor "helo" 2))
(check-expect (backspace (make-editor "hello" 0))
              (make-editor "hello" 0))

(define (backspace ed) 
  (cond
    [(= 0 (editor-idx ed)) ed]
    [else 
     (make-editor 
      (string-append (string-remove-last 
                       (substring (editor-txt ed) 0 (editor-idx ed)))
                     (substring (editor-txt ed) (editor-idx ed)
                                (string-length (editor-txt ed))))
                  (- (editor-idx ed) 1))]))

; Editor -> Boolean
(define (lengthOK ed) 
  (> WIDTH
     (image-width (text (string-append (editor-txt ed) "  ")
                        FONT-SIZE FONT-COLOR))))

; Editor -> Image
; return all characters upto the index value as a text image
(define (pre-txt ed)
  (text (substring (editor-txt ed) 0 (editor-idx ed)) FONT-SIZE FONT-COLOR))

; Editor -> Image
; return all characters from n to the string's end
(define (post-txt ed)
  (text (substring (editor-txt ed) 
                   (editor-idx ed) 
                   (string-length (editor-txt ed))) 
        FONT-SIZE FONT-COLOR))

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
  (main (make-editor s 0)))

; Editor -> Editor
; starts an editor
(define (main eds)
  (big-bang eds
            [to-draw render]
            [on-key  edit]))






