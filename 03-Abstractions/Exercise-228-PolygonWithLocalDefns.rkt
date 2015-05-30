;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-228-PolygonWithLocalDefns) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp")))))
; Exercise 228. 
; 
; Use a local expression to organize the functions for drawing a polygon in
; figure 48. If a globally defined functions is widely useful, do not make it
; local. 

; A Polygon is one of: 
; – (list Posn Posn Posn)
; – (cons Posn Polygon)

; A NELoP is one of: 
; – (cons Posn '())
; – (cons Posn NELoP)

; NOTE: defined last in the global space as, when defined in local
;       space it needed a check-expect but tests can only be defined
;       for top-level definitions (?? not sure, as yet, if there is 
;       another way to handle this)

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


; Polygon -> Image 
; adds an image of p to MT

(check-expect  (render-polygon  
                (list (make-posn 20 0) 
                      (make-posn 10 10)
                      (make-posn 30 10))) 
               (scene+line (scene+line   
                               (scene+line (empty-scene 50 50) 
                                           20 0 10 10 "red")
                                           10 10 30 10 "red")   
                              30 10 20 0 "red"))

(define (render-polygon p)
  (local (
    (define MT (empty-scene 50 50))
    
    ; NELoP -> Image
    ; connects the Posns in p in an image
    (define (connect-dots p)
      (cond
        [(empty? (rest p)) MT]
        [else 
         (render-line
          (connect-dots (rest p)) (first p) (second p))]))
    
    ; Image Posn Posn -> Image 
    ; draws a red line from Posn p to Posn q into im
    (define (render-line im p q)
      (scene+line
       im (posn-x p) (posn-y p) (posn-x q) (posn-y q) "red")))
     
    ; - IN -    
    
    (render-line (connect-dots p) (first p) (last p))))
