;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 0204-SP-FarenheitToCelsius) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp")))))
; 02.04 Sample Batch Program

; farenheit to celsisus
(define (f2c f)  (* 5/9 (- f 32)))

; main routine to read in afile of farenheit values,
; convert them to celsius values and write the result
; to a new file
(define (convert in out)  
  (write-file out  
     (number->string  
        (f2c 
          (string->number  
            (read-file in))))))

; usage example
(convert "sample.dat" "out.dat")
(read-file "out.dat")
