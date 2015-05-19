;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-185-WordGameCompleted) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 185. 
;
; Integrate arrangements (Exercise 184) with the partial program from Word 
; Games, Composition Illustrated. After making sure that the entire suite of
; tests passes, run it on some of your favorite examples.

(define DICTIONARY-LOCATION "words.txt")
(define DICTIONARY-AS-LIST (read-lines DICTIONARY-LOCATION))

; String -> List-of-strings
; find all words that the letters of some given word spell 
(check-member-of (alternative-words "cat")  
                 (list "act" "cat")   
                 (list "cat" "act"))

(define (all-words-from-rat? w)
  (and (member? "rat" w)     
       (member? "art" w)    
       (member? "tar" w)))

(check-satisfied (alternative-words "rat") all-words-from-rat?) 

(define (alternative-words s) 
  (in-dictionary (words->strings (arrangements (string->word s)))))

; -- from Exercise 181
; List-of-words -> List-of-strings
; turn all Words in low into Strings 
(check-expect (words->strings '()) '())
(check-expect (words->strings (list (list "c" "a" "t") 
                                    (list "r" "a" "t")))
              (list "cat" "rat"))

(define (words->strings low) 
  (cond [(empty? low) '()]
        [else (cons (word->string (first low)) 
                    (words->strings (rest low)))]))

; -- from Exercise 182
; List-of-strings -> List-of-strings
; pick out all those Strings that occur in the dictionary 
(check-expect (in-dictionary '()) '())
(check-expect (in-dictionary (list "act" "tca" "cat"))
              (list "act" "cat"))

(define (in-dictionary los) 
  (cond [(empty? los) '()]
        [(member? (first los) DICTIONARY-AS-LIST)
                  (cons (first los) (in-dictionary (rest los)))]
        [else (in-dictionary (rest los))]))

; -- from Exercise 184
;
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

; -- from Exercise 180
;
; A Word is either 
; – '() or
; – (cons 1String Word)
; interpretation a String as a list of single Strings (letters)

; String -> Word
; convert s to the chosen word representation 
(check-expect (string->word "") '())
(check-expect (string->word "cat") (list "c" "a" "t"))

(define (string->word s)
  (cond [(string=? "" s) '()]
        [else (explode s)]))

; Word -> String
; convert w to a string
(check-expect (word->string '()) '())
(check-expect (word->string (list "c" "a" "t")) "cat")

(define (word->string w)
  (cond [(empty? w) '()]
        [else (implode w)]))