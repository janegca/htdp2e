;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 09.03-SP-ContactList) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; 09.03 Sample Problem - Contact List
; 
; You are working on the contact list for some new cell phone. 
; The phone’s owner updates—adds and deletes names—and consults this list—looks 
; for specific names—on various occasions. For now, you are assigned the task
; of designing a function that consumes this list of contacts and determines 
; whether it contains the name “Flatt.”
;
; [NOTE: contains-flatt is an example of a recursive function]

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











