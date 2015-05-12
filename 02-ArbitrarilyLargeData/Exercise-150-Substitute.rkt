;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-150-Substitute) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 150. 
;
; Design the function subst-robot, which consumes a list of toy descriptions
; (strings) and replaces all occurrences of "robot" with "r2d2"; all other
; descriptions remain the same.
;
; Generalize subst-robot to the function substitute. The new function consumes
; two strings, called new and old, and a list of strings. It produces a new
; list of strings by substituting all occurrences of old with new.

(require racket/string)

; List-of-TD -> List-of-List-of-TD
; replaces all occurences of the word 'robot' in a list of
; toy descriptions, with the string 'r2d2'
(check-expect (subst-robot '()) '())
(check-expect (subst-robot (cons "rocket" '()))
              (cons "r2d2" '()))
(check-expect (subst-robot (cons "rocket"(cons "rocket man" '())))
              (cons "r2d2"(cons "r2d2 man" '())))

(define (subst-robot lotd)
  (cond [(empty? lotd) '()]
        [else 
         (cons (subst (first lotd))
               (subst-robot (rest lotd)))]))

; String -> String
; replace all definitions of rocket with r2d2
(check-expect (subst "rocket") "r2d2")
(check-expect (subst "rocket man") "r2d2 man")

(define (subst str)
  (if (string-contains? "rocket" str)
      (string-replace str "rocket" "r2d2")
      str))
      
; List-of-Strings OldString NewString -> List-of-Strings
; replaces the  OldString with the NewString  in the given list of strings
(check-expect (substitute '() "old" "new") '())
(check-expect (substitute (cons "rocket" '()) "rocket" "r2d2")
              (cons "r2d2" '()))
(check-expect (substitute (cons "rocket"(cons "rocket man" '())) 
                          "rocket" "r2d2")
              (cons "r2d2"(cons "r2d2 man" '())))

(define (substitute los old new)
  (cond [(empty? los) '()]
        [else (cons (string-replace (first los) old new)
                    (substitute (rest los) old new))]))