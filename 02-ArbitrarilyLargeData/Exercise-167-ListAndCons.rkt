;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-167-ListAndCons) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 167.
;
; Use cons and '() to construct the equivalent of the following lists:
;
;    (list 0 1 2 3 4 5)
;
;    (list (list "adam" 0) (list "eve" 1) (list "louisXIV" 2))
;
;    (list 1 (list 1 2) (list 1 2 3))
;
; Use check-expect to express your answers. 

(check-expect (list 0 1 2 3 4 5)
              (cons 0(cons 1(cons 2(cons 3(cons 4(cons 5 '())))))))

(check-expect (list (list "adam" 0) (list "eve" 1) (list "louisXIV" 2))
              (cons (cons "adam"(cons 0 '()))
                    (cons (cons "eve"(cons 1 '()))
                          (cons (cons "louisXIV"(cons 2 '())) '()))))

(check-expect (list 1 (list 1 2) (list 1 2 3))
              (cons 1(cons (cons 1(cons 2 '()))
                           (cons (cons 1(cons 2(cons 3 '()))) '()))))
              