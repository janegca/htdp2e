;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-229-WordGameWithLocalDefns) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 229.
; 
; Use a local expression to organize the functions for rearranging words 
; from Word Games, the Heart of the Problem.

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
  (local (
          ; 1String Word -> List-of-words
          ; insert the given 1String in the front, back and in-between each
          ; letter in the given word returning a list of new letter arrangements
          (define (insert-in-word c n w)
            (cond [(= 0 n) (list (insert c 0 w))]
                  [ else (append (list (insert c n w))
                                 (insert-in-word c (- n 1) w))]))
          
          ; 1String Number Word -> Word
          ; inserts a character into a word at the given position
          (define (insert c n w)
            (cond [(= 0 n) (cons c w)]
                  [else (cons (first w) (insert c (- n 1) (rest w)))]))
          )
    
  ; - IN -
  (cond [(empty? low) '()]
        [else (append (insert-in-word c (length (first low)) (first low))
                      (insert-everywhere/in-all-words  c (rest low)))])))

