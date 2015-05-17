;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-179-ConnectDotsRevised) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 179.
;
; Modify connect-dots so that it consumes an additional Posn structure to
; which the last Posn is connected. Then modify render-poly to use this new 
; version of connect-dots. Note This new version is called an accumulator 
; version. 

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

(define (render-poly p)
  (connect-dots p (first p)))

; Image Posn Posn -> Image 
; renders a line from p to q into im
(define (render-line im p q) 
  (scene+line  
   im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red"))
  
; NELoP -> Image
; connects the dots in the given list of Posns
(check-expect  (connect-dots 
                (list (make-posn 10 10) (make-posn 20 10) 
                      (make-posn 20 20) (make-posn 15 30))
                (make-posn 10 20))
               (scene+line
               (scene+line
                (scene+line   
                 (scene+line MT 10 10 20 10 "red")
                 20 10 20 20 "red")
                20 20 15 30 "red")
               15 30 10 20 "red"))

(define (connect-dots p ap) 
  (cond    
    [(empty? (rest p)) 
     (render-line MT (first p) ap)]
    [else 
     (render-line  
      (connect-dots (rest p) ap) (first p) (second p))]))
  
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
