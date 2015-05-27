;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-205-RankingsTable) (read-case-sensitive #t) (teachpacks ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 205. 
;
; Create the function make-ranking, which consumes a list of ranked song 
; titles and produces a list representation of an HTML table. Consider this
; example:

    (define one-list
      '("Asia: Heat of the Moment"
        "U2: One"
        "The White Stripes: Seven Nation Army"))

; If you apply make-ranking to one-list and display the result in a browser,
; you would see something like that: [an HTML table, first column has ranking
; second has list text]
;
; Hint: Although you could design a function that determines the rankings 
; from a list of strings, we wish you to focus on the creation of tables 
; instead. Thus we supply the following functions:
;
;   (define (ranking los)
;      (reverse (add-ranks (reverse los))))
;     
;    (define (add-ranks los)
;      (cond
;        [(empty? los) '()]
;        [else (cons (list (length los) (first los))
;                    (add-ranks (rest los)))]))
;
; Before you use these functions, equip them with signatures and purpose
; statements. Then explore their workings with interactions in DrRacket.
; Accumulators expands the design recipe with a way to create simpler 
; functions for computing rankings than ranking and add-ranks.

; A List-of-Rankings is one of:
; - '()
; - (cons Rank LOR)
;
; A Rank is one of:
; - '()
; - (cons Number(cons String '()))

; List-of-Strings -> List-of-Rankings
; generates a list of rankings from a list of strings
(define (ranking los)
  (reverse (add-ranks (reverse los))))

; List-of-Strings -> List-of-Rankings
; given a reversed list of strings, returns a list of rankings
(define (add-ranks los)
  (cond
    [(empty? los) '()]
    [else (cons (list (length los) (first los))
                (add-ranks (rest los)))]))

; Rank -> ... nested list ...
; turn a Rank into a nested list representing a row in a table of
; rankings
(check-expect (make-row (list 2 "U2: One"))
              (list (list 'td "2") (list 'td "U2: One")))

(define (make-row rank)
  (cond [(empty? rank) '()]
        [(number? (first rank)) 
         (cons (make-cell (number->string (first rank)))
               (make-row (rest rank)))]
        [else (cons (make-cell (first rank))
                    (make-row  (rest rank)))]))

; String -> List
(check-expect (make-cell "1") (list 'td "1"))

(define (make-cell val)
  `(td ,val))

; List-of-Strings -> ... nested list of rankings ...
; converts a list of string into a list representing a
; table of rankings
(check-expect (make-rank-table (list "U2: One"))
              (list 'table
                    (list (list 'border "1"))
                    (list 'tr (list 'td "1") (list 'td "U2: One"))))
                    
(define (make-rank-table los) 
  (cons 'table 
        (cons '((border "1"))
              (generate-table-rows (ranking los)))))

; List-of-Ranks -> ... nest list of rankings ....
; converts a list of rankings into a list representing a
; table of rankings
(check-expect (generate-table-rows '()) '())
(check-expect (generate-table-rows (list (list 2 "U2: One")) )
              (list (list 'tr (list 'td "2") (list 'td "U2: One"))))

(define (generate-table-rows lor)
  (cond [(empty? lor) '()]
        [else (cons `(tr ,@(make-row (first lor)))
                    (generate-table-rows (rest lor)))]))
        