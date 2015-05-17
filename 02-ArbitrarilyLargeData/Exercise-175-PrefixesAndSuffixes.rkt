;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-175-PrefixesAndSuffixes) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 175. 
; 
; Design prefixes. The function consumes a list of 1Strings and produces the 
; list of all prefixes. Recall that if a list p is a prefix of l, then p and l 
; are the same for all items in p. For example, (list 1 2 3) is a prefix of
; itself and (list 1 2 3 4).
;
; Design the function suffixes, which consumes a list of 1Strings and produces
; all suffixes. A list s is a suffix of l, then p and l are the same from the
; end for all items in s. For example, (list 2 3 4) is a suffix of itself and
; (list 1 2 3 4)

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
  (cond [(empty? los) '()]
        [else (cons los (prefixes (take (- (length los) 1) los)))]))

(define (take n los)
  (cond [(= 0 n) '()]
        [(= 1 n) (cons (first los) '())]
        [else (cons (first los) (take (- n 1) (rest los))) ]))

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
