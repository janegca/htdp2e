;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-203-Quasiquote) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 203. 
;
; Eliminate quasiquote and unquote from the following expressions so that
; they are written with list instead:
;
;    `(1 "a" 2 #false 3 "c")
;
;    this table-like shape:
;
;        `(("alan" ,(* 2 500))
;          ("barb" 2000)
;          (,(string-append "carl" " , the great") 1500)
;          ("dawn" 2300))
;
;    and this second web page:
;
;        `(html
;           (head
;             (title ,title))
;           (body
;             (h1 ,title)
;             (p "A second web page")))
;
;    where (define title "ratings").
;
;Also write down the nested lists that the expressions produce. 

(define ex1 `(1 "a" 2 #false 3 "c"))
(define ex1a (list 1 "a" 2 false 3 "c"))

(check-expect ex1 ex1a)

(define ex2 `(("alan" ,(* 2 500))
              ("barb" 2000)
              (,(string-append "carl" " , the great") 1500)
              ("dawn" 2300)))
(define ex2a (list (list "alan" 1000)
                   (list "barb" 2000)
                   (list "carl , the great" 1500)
                   (list "dawn" 2300)))
(check-expect ex2 ex2a)

(define title "ratings")

(define ex3 `(html
               (head
                (title ,title))
              (body
                (h1 ,title)
                (p "A second web page"))))
(define ex3a (list 'html
                   (list 'head
                         (list 'title "ratings"))
                   (list 'body
                         (list 'h1 "ratings")
                         (list 'p "A second web page"))))
(check-expect ex3 ex3a)
  