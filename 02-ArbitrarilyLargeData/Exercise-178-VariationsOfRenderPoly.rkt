;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-178-VariationsOfRenderPoly) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 178. 
;
; Here are two more ideas for defining render-poly:
;
;    render-poly could cons the last item of p onto p and then call 
;    connect-dots.
;
;    render-poly could add the first item of p to the end of p via a 
;    version of add-at-end that works on Polygons.
;
; Use both ideas to define render-poly; make sure both definitions pass the
; test cases.

; a Polygon is one of:
; – (list Posn Posn Posn) or (cons Posn (cons Posn (cons Posn '()))) 
; – (cons Posn Polygon)

(define MT (empty-scene 50 50)) 

; Polygon -> Image
; renders the given polygon p into MT
(check-expect  (render-poly   
                (list (make-posn 20 0) 
                      (make-posn 10 10)
                      (make-posn 30 10))) 
               (scene+line (scene+line   
                               (scene+line MT 20 0 10 10 "red")
                                               10 10 30 10 "red")   
                              30 10 20 0 "red"))

(check-expect  (render-poly   
                (list (make-posn 10 10) (make-posn 20 10) 
                      (make-posn 20 20) (make-posn 10 20))) 
               (scene+line   
                (scene+line  
                 (scene+line   
                  (scene+line MT 10 10 20 10 "red")    
                  20 10 20 20 "red")     
                 20 20 10 20 "red")  
                10 20 10 10 "red"))
 
(define (render-poly.v0 p)  
  (render-line (connect-dots p) (first p) (last p)))

; add last position as first position and connect all dots
(define (render-poly.v1 p)
  (connect-dots (cons (last p) p)))

; add first position as last position and connect all dots
; (requires a helper function)
(define (render-poly p)
  (connect-dots (add-at-end p (first p))))

; Polygon Posn -> NELoP
; add a position to the end of a polygon
(define (add-at-end nelop p) 
  (cond    [(empty? nelop) (cons p '())]  
           [else (cons (first nelop) (add-at-end (rest nelop) p))]))
  
; Image Posn Posn -> Image 
; renders a line from p to q into im
(define (render-line im p q) 
  (scene+line  
   im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))
  
; NELoP -> Image
; connects the dots in the given list of Posns
(check-expect  (connect-dots 
                (list (make-posn 10 10) (make-posn 20 10) 
                      (make-posn 20 20) (make-posn 10 20))) 
               (scene+line
                (scene+line   
                 (scene+line MT 10 10 20 10 "red")
                 20 10 20 20 "red")
                20 20 10 20 "red"))

(define (connect-dots p) 
  (cond    [(empty? (rest p)) MT]
           [else 
            (render-line  
             (connect-dots (rest p)) (first p) (second p))]))
  
; Polygon -> Posn
; extracts the last item from p
(check-expect (last (list (make-posn 10 10)
                          (make-posn 20 10)
                          (make-posn 30 10))) (make-posn 30 10))
(check-expect (last (list (make-posn 10 10)
                          (make-posn 20 10)
                          (make-posn 20 20)
                          (make-posn 10 20))) (make-posn 10 20))

(define (last p) 
  (cond  
    [(empty? (rest (rest (rest p)))) (third p)] 
    [else (last (rest p))]))

