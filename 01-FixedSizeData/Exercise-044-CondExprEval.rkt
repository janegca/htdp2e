;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-044-CondExprEval) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 44. 
; Enter the definition of reward and the application (reward 18) into 
; the Definitions area of DrRacket and use the stepper to find out how
; DrRacket evaluates applications of the function.

(define (reward s) 
  (cond    
    [(<= 0 s 10) "bronze"]   
    [(and (< 10 s) (<= s 20)) "silver"]    
    [else "gold"]))             

(reward 18)

