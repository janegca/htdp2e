;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-172-SortEmails) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 172. 
;
; Design a program that sorts lists of email messages by date:

    (define-struct email [from date message])
    ; A Email Message is a structure: 
    ;   (make-email String Number String)
    ; interpretation (make-email f d m) represents text m sent by
    ; f, d seconds after the beginning of time 

; Also develop a program that sorts lists of email messages by name. 
; To compare two strings alphabetically, use the string<? primitive.

; List-of-Emails -> List-of-Emails
; sort a list of emails by date
(check-expect (sort-by-date (list (make-email "John" 100 "msg")))
              (list (make-email "John" 100 "msg")))
(check-expect (sort-by-date (list (make-email "John" 100 "msg")
                                  (make-email "Paul"  50 "msg")))
              (list (make-email "John" 100 "msg")
                    (make-email "Paul" 50 "msg")))
              
(check-expect (sort-by-date (list (make-email "John" 50 "msg")
                                  (make-email "Paul" 150 "msg")))
              (list (make-email "Paul" 150 "msg")
                    (make-email "John" 50 "msg")))

(define (sort-by-date loe) 
  (cond [(empty? loe) '()]
        [else (insert-by-date (first loe) (sort-by-date (rest loe)))]))

(define (insert-by-date e loe)
  (cond [(empty? loe) (cons e '())]
        [else (if (> (email-date e) (email-date (first loe)))
                  (cons e loe)
                  (cons (first loe) (insert-by-date e (rest loe))))]))

; List-of-Emails -> List-of-Emails
; sort a list of emails by the senders name
(check-expect (sort-by-from (list (make-email "John" 100 "msg")))
              (list (make-email "John" 100 "msg")))
(check-expect (sort-by-from (list (make-email "Paul" 50 "msg")
                                  (make-email "John" 150 "msg")))
              (list (make-email "Paul" 50 "msg")
                    (make-email "John" 150 "msg")))
(check-expect (sort-by-from (list (make-email "John" 50 "msg")
                                  (make-email "Paul" 150 "msg")))
              (list (make-email "Paul" 150 "msg")
                    (make-email "John" 50 "msg")))

(define (sort-by-from loe) 
  (cond [(empty? loe) '()]
        [else (insert-by-from (first loe) (sort-by-from (rest loe)))]))

(define (insert-by-from e loe)
  (cond [(empty? loe) (cons e '())]
        [else (if (string>? (email-from e) (email-from (first loe)))
                  (cons e loe)
                  (cons (first loe) (insert-by-from e (rest loe))))]))
