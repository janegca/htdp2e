;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-121-Contains) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 122. 
; Develop the function contains?, which determines whether some given string
; occurs on a list of strings.
;
; Note BSL actually comes with member?, a function that consumes two values 
; and checks whether the first occurs in the second, which must be a list:
;
;    > (member? "Flatt" (cons "a" (cons "b" (cons "Flatt" '()))))
;
;    #true
;
; Don’t use member? to define the contains? function.

; String List-of-names -> Boolean
; determines whether the given name occurs on a-list-of-names
(check-expect (contains? "Flatt" '())                  #false)
(check-expect (contains? "Flatt" (cons "Findler" '())) #false)
(check-expect (contains? "Flatt" (cons "Flatt" '()))   #true)
(check-expect (contains? "Flatt" (cons "Mur" (cons "Fish"  (cons "Find" '()))))
               #false)
(check-expect (contains? "Flatt" (cons "A" (cons "Flatt" (cons "C" '())))) 
               #true)

(define (contains? name a-list-of-names) 
  (cond    [(empty? a-list-of-names) #false]    
           [(cons? a-list-of-names)     
            (cond [(string=? name (first a-list-of-names)) #true]      
                  [else (contains? name (rest a-list-of-names))])]))

(define ex1
    (cons "Fagan"
      (cons "Findler"
        (cons "Fisler"
          (cons "Flanagan"
            (cons "Flatt"
              (cons "Felleisen"
                (cons "Friedman" '()))))))))


(contains? "Flatt" ex1)
