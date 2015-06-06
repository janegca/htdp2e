;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-239-RevisitingPrefixesAndSuffixes) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 239. 
; 
; Use existing abstractions to define the prefixes and suffixes functions from
; exercise 175. Ensure that they pass the same tests as the original function. 

; NOTE: this is not what was asked; should be solved using  higher order
;       functions

; List-of-1Strings -> LLS
; returns all the prefixes that can be generated from a list of 1Strings
(check-expect (prefixes '()) '())
(check-expect (prefixes (list "a")) (list (list "a")))
(check-expect (prefixes (list "a" "b" "c" "d"))
              (list (list "a" "b" "c" "d") 
                    (list "a" "b" "c")
                    (list "a" "b") 
                    (list "a")))

(define (prefixes los)
  (local (; 
          (define (take n lst)
            (cond [(= 0 n) '()]
                  [(= 1 n) (cons (first lst) '())]
                  [else (cons (first lst) (take (- n 1) (rest lst))) ])))
          
  (cond [(empty? los) '()]
        [else (cons los (prefixes (take (- (length los) 1) los)))])))


; List-of-1Strings -> LLs
; returns all the suffixes that can be generated from a list of 1Strings
(check-expect (suffixes '()) '())
(check-expect (suffixes (list "a" "b"))
              (list (list "a" "b") (list "b")))
(check-expect (suffixes (list "a" "b" "c" "d"))
              (list (list "a" "b" "c" "d") 
                    (list "b" "c" "d") 
                    (list "c" "d") 
                    (list "d")))

(define (suffixes los)
  (cond [(empty? los) '()]
        [else (cons los (suffixes (rest los)))]))
  