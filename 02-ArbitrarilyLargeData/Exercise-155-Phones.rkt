;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-155-Phones) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 155. 
; 
; Here is one way to represent a phone number:

    (define-struct phone [area switch four])
    ; A Phone is a structure: 
    ;   (make-phone Three Three Four)
    ; A Three is between 100 and 999. 
    ; A Four is between 1000 and 9999. 

; Design the function replace. It consumes a list of Phones and produces one. 
; It replaces all occurrence of area code 713 with 281. 

; List-of-Phones -> List-of-Phones
; replaces all occurrences of area code 713 with 281.
(check-expect (replace '()) '())
(check-expect (replace (cons (make-phone 713 999 9999) '()))
              (cons (make-phone 281 999 9999) '()))
(check-expect (replace (cons (make-phone 713 999 9999)
                             (cons (make-phone 713 555 55555) '())))
              (cons (make-phone 281 999 9999)
                    (cons (make-phone 281 555 55555) '())))
(check-expect (replace (cons (make-phone 999 999 9999) '()))
              (cons (make-phone 999 999 9999) '()))
(check-expect (replace (cons (make-phone 999 999 9999)
                             (cons (make-phone 713 555 5555) '())))
              (cons (make-phone 999 999 9999)
                    (cons (make-phone 281 555 5555) '())))

(define (replace lop)
  (cond [(empty? lop) lop]
        [(cons?  lop)
         (cons (replace-area-code (first lop))
               (replace (rest lop)))]))

; Phone -> Phone
; replaces a 713 area code with 281
(define (replace-area-code p)
  (if (= 713 (phone-area p))
      (make-phone 281 (phone-switch p) (phone-four p))
      p))
  
                       
