;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-184-Arrangements) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 184. 
;
; Design insert-everywhere/in-all-words. It consumes a 1String and a list of
; words. The result is a list of words like its second argument, but with the 
; first argument inserted at the beginning, between all letters, and at the 
; end of all words of the given list.
;
; Start with a complete wish list entry. Supplement it with tests for empty 
; lists, a list with a one-letter word and another list with a two-letter
; word, etc. Before you continue, study the following three hints carefully.
;
; Hints (1) Reconsider the example from above. It says that "d" needs to be 
; inserted into the words (list "e" "r") and (list "r" "e"). The following
; application is therefore one natural candidate for an example and unit test:
;
;    (insert-everywhere/in-all-words "d"
;      (cons (list "e" "r")
;        (cons (list "r" "e")
;          '())))
;
; Keep in mind that the second input corresponds to the sequence of (partial)
; words “er” and “re”.
;
; (2) You want to use the BSL+ operation append, which consumes two lists and
; produces the concatenation of the two lists:
;
;    > (append (list "a" "b" "c") (list "d" "e"))
;   (list "a" "b" "c" "d" "e")
;
; the development of functions like append is the subject of section 
; Simultaneous Processing.
;
; (3) This solution of this exercise is a series of functions. Patiently
; stick to the design recipe and systematically work through your wish list. 

; Word -> List-of-words
; find all re-arrangements of word
(check-expect (arrangements (list "d" "e" "r"))
              (list
               (list "r" "e" "d")
               (list "r" "d" "e")
               (list "d" "r" "e")
               (list "e" "r" "d")
               (list "e" "d" "r")
               (list "d" "e" "r")))
               
(define (arrangements w)  
  (cond   
    [(empty? w) (list '())]  
    [else (insert-everywhere/in-all-words (first w)  
                                          (arrangements (rest w)))]))

; 1String List-of-words -> List-of-words
; insert the given 1String into every position in every word
; in the given list of words
(check-expect (insert-everywhere/in-all-words "d" (list (list "r" "e") 
                                                        (list "e" "r")))
              (list
               (list "r" "e" "d")
               (list "r" "d" "e")
               (list "d" "r" "e")
               (list "e" "r" "d")
               (list "e" "d" "r")
               (list "d" "e" "r")))            
              
(define (insert-everywhere/in-all-words c low) 
  (cond [(empty? low) '()]
        [else (append (insert-in-word c (length (first low)) (first low))
                      (insert-everywhere/in-all-words  c (rest low)))]))

; 1String Word -> List-of-words
; insert the given 1String in the front, back and in-between each
; letter in the given word returning a list of new letter arrangements
(check-member-of (insert-in-word "d" 2 (list "r" "e"))
                 (list (list "r" "e" "d")
                       (list "r" "d" "e")
                       (list "d" "r" "e")))               
                 
(define (insert-in-word c n w)
  (cond [(= 0 n) (list (insert c 0 w))]
        [ else (append (list (insert c n w))
                       (insert-in-word c (- n 1) w))]))

; 1String Number Word -> Word
; inserts a character into a word at the given position
(check-expect (insert "d" 0 (list "r" "e")) (list "d" "r" "e"))
(check-expect (insert "d" 1 (list "r" "e")) (list "r" "d" "e"))
(check-expect (insert "d" 2 (list "r" "e")) (list "r" "e" "d"))

(define (insert c n w)
  (cond [(= 0 n) (cons c w)]
        [else (cons (first w) (insert c (- n 1) (rest w)))]))
