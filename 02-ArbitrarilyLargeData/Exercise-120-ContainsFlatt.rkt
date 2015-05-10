;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-120-ContainsFlatt) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 120. 
; Use DrRacket to run contains-flatt? in this example:

(define ex1
    (cons "Fagan"
      (cons "Findler"
        (cons "Fisler"
          (cons "Flanagan"
            (cons "Flatt"
              (cons "Felleisen"
                (cons "Friedman" '()))))))))

; What answer do you expect? 

; List-of-names -> Boolean
; determines whether "Flatt" occurs on a-list-of-names
(check-expect (contains-flatt? '())                  #false)
(check-expect (contains-flatt? (cons "Findler" '())) #false)
(check-expect (contains-flatt? (cons "Flatt" '()))   #true)
(check-expect (contains-flatt? (cons "Mur" (cons "Fish"  (cons "Find" '()))))
               #false)
(check-expect (contains-flatt? (cons "A" (cons "Flatt" (cons "C" '())))) 
               #true)

(define (contains-flatt? a-list-of-names) 
  (cond    [(empty? a-list-of-names) #false]    
           [(cons? a-list-of-names)     
            (or (string=? (first a-list-of-names) "Flatt")      
                (contains-flatt? (rest a-list-of-names)))]))

(contains-flatt? ex1)



