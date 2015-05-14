;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-159-EncodeFile) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; Exercise 159. 
; 
; Design a program that encodes text files numerically. Each letter in a word 
; should be encoded as a numeric three-letter string with a value between 0
; and 256. Here is our encoding function for letters:

; 1String -> String
; converts the given 1string into a three-letter numeric string 

; 1String -> String
; auxiliary for stating tests 
(define (code1 c) 
  (number->string (string->int c))) 

(check-expect (encode-letter "\t") (string-append "00" (code1 "\t")))
(check-expect (encode-letter "a") (string-append "0" (code1 "a")))
(check-expect (encode-letter "z") (code1 "z"))

(define (encode-letter s)
  (cond    [(< (string->int s) 10)
            (string-append "00" (code1 s))]  
           [(< (string->int s) 100) (string-append "0" (code1 s))]  
           [else (code1 s)]))

; Before you start, explain this function. Also recall how a string can be 
; converted into a list of 1Strings.
;
; Again, use read-words/line to preserve the organization of the file into 
; lines and words.

(define (encode-file fn)
  (encode-lls (read-words/line fn)))

; List-of-Los -> String
; encodes a list of list of strings, returning a single string
(define los1 (cons "the"(cons "cat" '())))
(define los2 (cons "in"(cons "the" (cons "hat" '()))))
(define lls1 (cons los1 (cons los2 '())))

(check-expect (encode-lls lls1)
              "116104101 099097116\n105110 116104101 104097116\n")

(define (encode-lls lls)
  (cond [(empty? lls) ""]
        [(cons?  lls)
         (string-append (encode-los (first lls)) "\n"
            (cond [(empty? (rest lls)) ""]
                  [else (encode-lls (rest lls))]))]))

; List-of-Strings -> String
; encode a list of strings, returning the result as a string
(check-expect (encode-los (cons "the"(cons "cat" '())))
              (string-append (encode-letter "t")
                             (encode-letter "h")
                             (encode-letter "e")
                             " "
                             (encode-letter "c")
                             (encode-letter "a")
                             (encode-letter "t")))

              
(define (encode-los los)
  (cond [(empty? los) ""]
        [(cons?  los)
         (cond 
           [(empty? (rest los))
                    (encode-loc (explode (first los)))]
           [else (string-append (encode-loc (explode (first los)))
                 " "
                 (encode-los (rest los)))])]))

; List-of-characters -> String
; encode a list of characters, returning the result as a string
(check-expect (encode-loc (explode "cat"))
              (string-append (encode-letter "c")
                             (encode-letter "a")
                             (encode-letter "t")))
                                   
(define (encode-loc loc)
  (cond [(empty? loc) ""]
        [(cons?  loc)
         (string-append (encode-letter (first loc))
                        (encode-loc (rest loc)))]))

; usage example
(encode-file "ttt.txt")