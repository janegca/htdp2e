;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-360-zip) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 360.
;
; Design the zip function, which consumes a list of names, represented as
; strings, and a list phone numbers, also strings. It combines those equally
; long lists into a list of phone records:

    (define-struct phone-record [name number])
    ; A PhoneRecord is (make-phone-record String String).

; The assumption is that corresponding list items belong to the same person.

; [List-of String] [List-of String] -> [List-of PhoneRecord]
; a list of phone records created by combining the given names and
; phone numbers
; assume corresponding list items belong to the same person.
(check-expect (zip '() '()) '())
(check-expect (zip '("John") '("123-456-7890"))
              `(,(make-phone-record "John" "123-456-7890")))
(check-expect (zip '("John" "Ringo") '("123-456-7890" "123-456-7891"))
              `(,(make-phone-record "John" "123-456-7890")
                ,(make-phone-record "Ringo" "123-456-7891")))

(define (zip n* p*)
  (cond [(empty? n*) '()]
        [else (cons (make-phone-record (first n*) (first p*))
                      (zip (rest n*) (rest p*)))]))
