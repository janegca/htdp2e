;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-121-ContainsFlattRev) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 121. 
; Here is another way of formulating the second cond clause in contains-flatt?:
;
;    ... (cond
;          [(string=? (first a-list-of-names) "Flatt") #true]
;          [else (contains-flatt? (rest a-list-of-names))]) ...
;
; Explain why this expression produces the same answers as the or expression 
; in the version of figure 33. Which version is better? Explain. ;
;
; Ans: 
;    While both formulations work their way through the ex1 list, stopping
;    when 'Flatt' is found, this formulation evaluates the else at each
;    step; Exercise 120 builds a list of evaulations: (or false (or false ..)
;    performing the evaluation only when a match is found. If the list
;    was extremely long you may possibly run out of memory before getting
;    to a definitive result.

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
            (cond [(string=? (first a-list-of-names) "Flatt") #true]      
                  [else (contains-flatt? (rest a-list-of-names))])]))

(contains-flatt? ex1)



