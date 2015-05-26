;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-204-UnquoteSplicing) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 204. 
;
; Eliminate quasiquote, unquote, and unquote-splicing from the following
; expressions so that they are written with list instead:
;
;    `(0 ,@'(1 2 3) 4)
;
; this table-like shape: 
;
; `(("alan" ,(* 2 500))
;    ("barb" 2000)
;    (,@'(list "carl" " , the great")   1500)
;    ("dawn" 2300))
;
; and this third web page: 
;
; `(html
;   (body
;     (table ((border "1"))
;       (tr ((width "200")) ,@(make-row '( 1  2)))
;       (tr ((width "200")) ,@(make-row '(99 65))))))
;
;     where make-row is the function from above.
;
; Also write down the nested lists that the expressions produce. 

(define ex1 `(0 ,@'(1 2 3) 4))
(define ex1a (list 0 1 2 3 4))
(check-expect ex1 ex1a)

(define ex2 `(("alan" ,(* 2 500))
              ("barb" 2000)
              (,@'(list "carl" " , the great")   1500)
              ("dawn" 2300)))
(define ex2a (list (list "alan" 1000)
                   (list "barb" 2000)
                   (list 'list "carl" " , the great" 1500)
                   (list "dawn" 2300)))
(check-expect ex2 ex2a)


; List-of-numbers -> ... nested list ...
; creates a row for an HTML table from a list of numbers 
(define (make-row l)
  (cond
    [(empty? l) '()]
    [else (cons (make-cell (first l)) 
                (make-row  (rest l)))]))

; Number -> ... nested list ...
; creates a cell for an HTML table from a number 
(define (make-cell n)
  `(td ,(number->string n)))

(define ex3 `(html
               (body
                 (table ((border "1"))
                   (tr ((width "200")) ,@(make-row '( 1  2)))
                   (tr ((width "200")) ,@(make-row '(99 65)))))))
(define ex3a (list 'html
                   (list 'body
                         (list 'table
                               (list (list 'border "1"))
                               (list 'tr 
                                     (list (list 'width "200"))
                                     (list 'td "1")
                                     (list 'td "2"))
                               (list 'tr
                                     (list (list 'width "200"))
                                     (list 'td "99")
                                     (list 'td "65"))))))
(check-expect ex3 ex3a)
                                         
  