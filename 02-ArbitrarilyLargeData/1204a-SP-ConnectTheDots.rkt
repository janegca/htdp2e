;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 1204a-SP-ConnectTheDots) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; 12.04a - Sample Problem - Connect the dots
;
; A more generalized version of the 'Draw a Polygon' problem.
;

; A NELoP (non-empty list of Posns) is one of: 
; – (cons Posn '())
; – (cons Posn NELoP)

(define MT (empty-scene 50 50)) 

; NELoP -> Image 
; connects the dots in p by rendering lines in MT
(check-expect (connect-dots (list (make-posn 20 0)    
                                  (make-posn 10 10)   
                                  (make-posn 30 10))) 
              (scene+line            
               (scene+line MT 20 0 10 10 "red")     
               10 10 30 10 "red"))

; -- Ans to Exercise 176
(check-expect  (connect-dots 
                (list (make-posn 10 10) (make-posn 20 10) 
                      (make-posn 20 20) (make-posn 10 20))) 
               (scene+line
                (scene+line   
                 (scene+line MT 10 10 20 10 "red")
                 20 10 20 20 "red")
                20 20 10 20 "red"))


(define (connect-dots p) 
  (cond    [(empty? (rest p)) MT]   ; simplfies first cond of render-poly
           [else 
            (render-line  
             (connect-dots (rest p)) (first p) (second p))]))

; Image Posn Posn -> Image 
; renders a line from p to q into im
(define (render-line im p q) 
  (scene+line  
   im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))






