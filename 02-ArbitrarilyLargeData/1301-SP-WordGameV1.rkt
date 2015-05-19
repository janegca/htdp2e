;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 1301-SP-WordGameV1) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; 13.01 - Sample Problem - Word Games v 1
;
; Given a word, find (all possible) words that are made up from some letters. 
; For example “cat” also spells “act.”
;
; After solving Exercise 180


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

; List-of-words -> List-of-strings
; turn all Words in low into Strings 
(define (words->strings low) low)

; List-of-strings -> List-of-strings
; pick out all those Strings that occur in the dictionary 
(define (in-dictionary los) los)

; Word -> List-of-words
; find all re-arrangements of word
(define (arrangements word) 
  (list word))

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
