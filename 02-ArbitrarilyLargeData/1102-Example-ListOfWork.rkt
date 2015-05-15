;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 11.02-Example-ListOfWork) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 11.02 - Example - List of Work

(define-struct work [employee rate hours])
; Work is a structure: (make-work String Number Number). 
; interpretation (make-work n r h) combines the name (n) 
; with the pay rate (r) and the number of hours (h) worked.

; Low (list of works) is one of:
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the work efforts
; of some hourly employees

; Low -> List-of-numbers
; computes the weekly wages for all given weekly work records 
(check-expect  (wage*.v2 (cons (make-work "Robby" 11.95 39) '())) 
               (cons (* 11.95 39) '()))

(define (wage*.v2 an-low)  
  (cond    
    [(empty? an-low) '()]  
    [(cons? an-low) 
     (cons (wage.v2 (first an-low))                        
           (wage*.v2 (rest an-low)))])) 

; Work -> Number
; computes the wage for the given work record w
(define (wage.v2 w) 
  (* (work-rate w) (work-hours w)))





