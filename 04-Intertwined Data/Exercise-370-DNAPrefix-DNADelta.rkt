;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-370-DNAPrefix-DNADelta) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 370.
;
; Design the function DNAprefix. The function takes two arguments, both lists
; of 'a, 'c, 'g, and 't, symbols that occur in DNA descriptions. The first
; list is called a pattern, the second one a search string. The function
; returns #true if the pattern is identical to the initial part of the
; search string. Otherwise the function returns #false.
;
; Also design DNAdelta. This function is like DNAprefix but returns the first
; item in the search string beyond the pattern. If the lists are identical and
; there is no DNA letter beyond the pattern, the function signals an error.
; If the pattern does not match the beginning of the search string, the
; function returns #false. The function must not process either of the lists
; more than once.
;
; Can DNAprefix or DNAdelta be simplified?

; [List-of Symbol] [List-of Symbol] -> Boolean
; true if the beginning of the string to be searched (s) matches
; the pattern string (p); otherwise, false
(check-expect (DNAprefix '() '())        #true)
(check-expect (DNAprefix '(a c t g) '()) #false)
(check-expect (DNAprefix '() '(a c t))   #true)
(check-expect (DNAprefix '(a c t g) '(a c t g g t c a)) #true)
(check-expect (DNAprefix '(a c t g) '(a t c g g t c a)) #false)

(define (DNAprefix p s)
  (cond [(empty? p) #true]
        [(empty? s) #false]
        [(eq? (first p) (first s))
         (DNAprefix (rest p) (rest s))]
        [else #false]))

; [List-of Symbol] [List-of Symbol] -> [Maybe Symbol]
; the first symbol after the matched pattern; otherwise,
; false (if pattern prefix not matched) or an error
; (if there is not symbol beyond the matched prefix)
(check-expect (DNAdelta '(a c t) '(a c t g)) 'g)
(check-expect (DNAdelta '(a c t) '(a t c g)) #false)
(check-error  (DNAdelta '(a c t) '(a c t)))

(define (DNAdelta p s)
  (cond [(and (empty? p) (cons? s)) (first s)]
        [(empty? s) (error 'DNAdelta "missing symbol")]
        [(eq? (first p) (first s))
         (DNAdelta (rest p) (rest s))]
        [else #false]))