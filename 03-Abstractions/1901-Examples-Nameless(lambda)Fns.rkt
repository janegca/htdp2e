;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |1901-Examples-Nameless(lambda)Fns|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 19.01 - Examples - Nameless Functions (lambda's)

; (lambda (var1, var2, ..., varN) <function body>))
;
; 'lambda' creates a function with a name that we don't know
; so, for us, it is nameless or anonymous function

((lambda (x) (expt 10 x)) 2)

((lambda (name) (string-append "hello, " name ", how are you?")) "Robby")
((lambda (name rst) (string-append name ", " rst)) "Robby" "etc.")


(map (lambda (x) (expt 10 x))
       '(1 2 3))

(foldl (lambda (name rst) (string-append name ", " rst)) "etc."
         '("Matthew" "Robby"))

(define-struct ir [name price])
(define threshold 20)
(filter (lambda (ir) (<= (ir-price ir) threshold))
          (list (make-ir "bear" 10) (make-ir "doll" 33)))

