;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-173-SortByScore) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 173. 
;
; Design a program that sorts lists of game players by score:

    (define-struct gp [name score])
    ; A GamePlayer is a structure: 
    ;    (make-gp String Number)
    ; interpretation (make-gp p s) represents player p who scored
    ; a maximum of s points 

; List-of-GamePlayers -> List-of-GamePlayers
; sort a list of GamePlayers by score
(check-expect (gp> '()) '())
(check-expect (gp> (list (make-gp "a" 20))) (list (make-gp "a" 20)))
(check-expect (gp> (list (make-gp "a" 30)
                         (make-gp "b" 10))) (list (make-gp "a" 30)
                                                  (make-gp "b" 10)))
(check-expect (gp> (list (make-gp "a" 20)
                         (make-gp "b" 30))) (list (make-gp "b" 30)
                                                  (make-gp "a" 20)))

(define (gp> logp) 
  (cond [(empty? logp) '()]
        [else (insert-by-score (first logp) (rest logp))]))

; GamePlayer List-of-GamePlayers -> List-of-GamePlayers
; inserts a GamePlayer into a list of gameplayers sorted in
; descending scores
(define (insert-by-score g logp)
  (cond [(empty? logp) (cons g '())]
        [else (if (> (gp-score g) (gp-score (first logp)))
                  (cons g logp)
                  (cons (first logp) (insert-by-score g (rest logp))))]))
