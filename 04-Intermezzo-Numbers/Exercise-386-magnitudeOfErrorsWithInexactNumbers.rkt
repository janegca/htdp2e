;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |Exercise-386-large numbers|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 386.
;
; When you add two inexact numbers of vastly different orders of magnitude,
; you may get the larger one back as the result.
;
; Consider the following list of numbers:

(define JANUS
  (list 31.0
        #i2e+34
        #i-1.2345678901235e+80
        2749.0
        -2939234.0
        #i-2e+33
        #i3.2e+270
        17.0
        #i-2.4e+270
        #i4.2344294738446e+170
        1.0
        #i-8e+269
        0.0
        99.0))

(define (sum n*)
  (foldl + 0 n*))

(sum JANUS)             ; #i99.0
(sum (reverse JANUS))   ; #i-1.2345678901235e+080
(sum (sort JANUS <))    ; #i0.0

(define (sumr n*)
  (foldr + 0 n*))

(sumr JANUS)            ; #i-1.2345678901235e+080
(sumr (reverse JANUS))  ; #i99.0
(sumr (sort JANUS <))   ; #i0.0

; If you search on the world wide web concerning calculations with inexact
; numbers (floats), you may find advice that says start with the smallest
; numbers because adding a big number to two small numbers might yield the
; former, but adding a big number to the sum of two small ones might change
; the outcome:

(expt 2 #i53.0)                           ; #i9007199254740992.0
(sum (list #i1.0 (expt 2 #i53.0)))        ; #i9007199254740992.0
(sum (list #i1.0 #i1.0 (expt 2 #i53.0)))  ; #i9007199254740994.0

; Unfortunately, the third of the above sum expressions shows that this
; advice does not work. Explain why.

; Ans: Small variances in internal representations accumulate into
;      larger variances

; In a language such as ISL+, it does work to convert all the numbers to
; exact rationals, use exact arithmetic on the resulting list, and convert
; the sum of the list back to an inexact number:

(exact->inexact (sum (map inexact->exact JANUS)))  ; #i4.2344294738446e+170

; Evaluate this expression and compare the result to the three sums above.
; What do you think now about advice from the web?









  

