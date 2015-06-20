;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-332-xexpr-name-and-xexpr-content) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 332. Design the functions xexpr-name and xexpr-content.

(define-struct element [name attributes content])
; An Xexpr.v2 is 
; – (cons Symbol [List-of Xexpr.v2])
; – (cons Symbol (cons [List-of Attribute] [List-of Xexpr.v2]))

; S-expr examples using the Quote, Unquote mechanism
(define a0 '((initial "red")))
 
(define e0 '(machine))
(define e1 `(machine ,a0))
(define e2 '(machine (action)))
(define e3 '(machine () (action)))
(define e4 `(machine ,a0 (action) (action)))

; Xexpr.v2 -> Symbol
; the name of the xml expression
(check-expect (xexpr-name e0) 'machine)
(check-expect (xexpr-name e4) 'machine)
(check-error  (xexpr-name a0))

(define (xexpr-name xe)
  (cond [(symbol? (first xe)) (first xe)]
        [else (error "not an Xexpr")]))

; Xexpr.v2 -> [List-of Xexpr.v2]
; retrieves the list of contents for xe
(check-expect (xexpr-content e0) '())
(check-expect (xexpr-content e1) '())
(check-expect (xexpr-content e2) '(action))
(check-expect (xexpr-content e3) '(action))
(check-expect (xexpr-content e4) '((action) (action)))

(define (xexpr-content xe)
  (local ((define opts (rest xe)))
  (cond [(or (empty? xe) 
             (empty? opts)) '()]              ; no attributes or content
        [(empty? (first opts)) (second opts)] ; no attributes
        [(empty? (rest opts))                 ; only one option available
         (if (symbol? (first (first opts)))   ; is it attributes or content?
             (first opts)                     ;   it's content
             '())]                            ;   it's attributes
        [else (rest opts)]))) ; first option is attributes, rest are content
