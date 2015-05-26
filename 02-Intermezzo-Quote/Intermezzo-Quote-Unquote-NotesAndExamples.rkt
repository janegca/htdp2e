;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Intermezzo-Quote-Unquote-NotesAndExamples) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")))))
; Intermezzo - Quote, Unquote

; -- you can create lists using the quote symbol (')

(define ex1 '(1 2 3))                  ; (list 1 2 3)
(define ex2 '("a" "b" "c"))            ; (list "a" "b" "c")
(define ex3 '(#true "hello" 42))       ; (list true "hello" 42)

; -- easily create nested lists
(define nl1 '(("a" 1)
              ("b" 2)
              ("d" 4))) ; (list (list "a" 1) (list "b" 2) (list "d" 4))

; -- quote gotcha's

(define x 42)

; x is treated as 'the symbol for a value'
(define ex4 '(40 41 x 43 44))  ; (list 40 41 'x 43 44)

; here, a (+) is treated as a symbol '+
(define ex5 '(1 (+ 1 1) 3))    ; (list 1 (list '+ 1 1) 3)

; if you don't want list member to be treated as a symbol
; you need use a quasiquote (back-tick), which appears to act
; just like a quote
(define ex6 `(1 2 3))     ; (list 1 2 3)

; however, you can 'unquote' a quasi-quote to force the evaluation
; of a value, just place a comma before the symbol
(define ex7 `(40 41 ,x 43 44))  ; (list 40 41 42 43 44)
(define ex8 `(1 ,(+ 1 1) 3))    ; (list 1 2 3)

(define ex7a (quasiquote (40 41 (unquote x) 43 44)))
(define ex8a (quasiquote (1 (unquote (+ 1 1)) 3)))

(check-expect ex7 ex7a)
(check-expect ex8 ex8a)

; when a quote (or quasiquote) is followed by an opening parentheses,
; 'list' is inserted after the parenteses and a quote is added
; to every element until a closing parenthese is encountered
; if the quote shows up next to a basic piece of data, it disappears
; ie '(1 2 3) -> (list '1 '2 '3) -> (list 1 2 3)

; the quote, quasiquote, unquote mechanism allows one to easily write
; web pages

; String String -> ... deeply nested list ...
; produces a (representation of) a web page with given author and title
(define (my-first-web-page author title)
  `(html
     (head
       (title ,title)
       (meta ((http-equiv "content-type")
              (content "text-html"))))
     (body
       (h1 ,title)
       (p "I, " ,author ", made this page."))))

; No web-io.rkt file or show-in-browser function available
; (show-in-browser (my-first-web-page "Jane" "hello"))

; Unquote Splice
;

(define (make-row lst)
  (cond [(empty? lst) '()]
        [else (cons (number->string (first lst))
                    (make-row (rest lst)))]))

(define ex9 `(tr ,(make-row '(1 2 3 4 5))))  
; result of ex9: (list 'tr (list "1" "2" "3" "4" "5"))

; if we want one list vs a nested list result, we can use cons
(define ex9a (cons 'tr (make-row '(1 2 3 4 5))))
; result:
;  (list 'tr "1" "2" "3" "4" "5")

; or we can use 'unquote-splicing'
(define ex9b `(tr ,@(make-row '(1 2 3 4 5))))

(check-expect ex9a ex9b)

;--  Example of creating an HTML table

; List-of-numbers -> ... nested list ...
; creates a row for an HTML table from a list of numbers 
(define (make-table-row l)
  (cond
    [(empty? l) '()]
    [else (cons (make-table-cell (first l)) 
                (make-table-row  (rest l)))]))
 
; Number -> ... nested list ...
; creates a cell for an HTML table from a number 
(define (make-table-cell n)
  `(td ,(number->string n)))

(define ex10  (make-table-cell 2))      ; (list 'td "2")
(define ex10a (make-table-row '(1 2)))  ; (list (list 'td "1") (list 'td "2"))

; to build a table we need to splice the row results
; to get each row a list of cell elements which are, themselves,
; lists

; List-of-numbers List-of-numbers -> ... nested list ...
; creates an HTML table from two lists of numbers 
(define (make-table row1 row2)
  `(table ((border "1"))
          (tr ,@(make-table-row row1))
          (tr ,@(make-table-row row2))))

(define ex10c  (make-table '(1 2 3 4 5) '(3.5 2.8 -1.1 3.4 1.3)))
