;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 1204-SP-DrawAPolygon) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; 12.04 - Sample Problem - Draw A Polygon
;
; Design a program that renders a polygon into an empty 50 by 50 scene.
;
; A polygon is a planar figure with at least three corners consecutively 
; connected by three straight sides. And so on.
;
; [Note: render-poly fails here, need a more generalized approach
;        see 12.04a Sample Problem]

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
                  20 10 20 20 "red")      20 20 10 20 "red")  
                10 20 10 10 "red"))


(define (render-poly p)  
  (cond    
    [(empty? (rest (rest (rest p))))
     (render-line 
      (render-line  
       (render-line MT (first p) (second p)) 
       (second p) (third p))  (third p) (first p))]
    [else 
     (render-line      
      (render-poly (rest p)) (first p) (second p))]))

; Image Posn Posn -> Image 
; renders a line from p to q into im
(define (render-line im p q) 
  (scene+line  
   im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))
