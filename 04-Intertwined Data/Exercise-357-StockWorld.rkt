;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-357-StockWorld) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 357.
; Here is the get function missing from figure 86 (added below, after
; Figure 86 code).
;
; Design get-xexpr. Derive functional examples for this function from those
; for get. Generalize these examples so that you are confident get-xexpr can
; traverse an arbitrary Xexpr.v3. Finally, formulate a test that uses the web
; data saved in exercise 356.

; NOTE: Not completed 

; -- code from figure 86
(require 2htdp/image)
(require 2htdp/batch-io)
(require 2htdp/universe)

(define PREFIX "https://www.google.com/finance?q=")
(define SUFFIX "&btnG=Search")
(define SIZE 22)
(define SPACER (text "  " SIZE 'white))
 
(define-struct data [price delta])
; StockWorld is
;    (make-data String String)
; price and delta specify the current price and how 
; much it changed since the last update 
 
; String -> StockWorld
; retrieves stock price and its change of the specified company
; every 15 seconds and displays together with available time stamp
(define (stock-alert company)
  (local ((define url (string-append PREFIX company SUFFIX))
 
          ; [StockWorld -> StockWorld]
          ; retrieves price and change from url
          (define (retrieve-stock-data __w)
            (local ((define x (read-xexpr/web url)))
              (make-data (get x "price") (get x "priceChange"))))
 
          ; StockWorld -> Image 
          ; renders the stock market data as a single long line 
          (define (render-stock-data w)
            (local ((define pt (text (data-price w) SIZE 'black))
                    (define dt (text (data-delta w) SIZE 'red)))
              (overlay (beside pt SPACER dt)
                       (rectangle 300 35 'solid 'white)))))
    ; – IN – 
    (big-bang (retrieve-stock-data 'no-use)
              [on-tick retrieve-stock-data 15]
              [to-draw render-stock-data]
              [name company])))

; Xexpr.v3 String -> String
; retrieves the value of the "content" attribute for 
; a 'meta element with attribute "itemprop" and value s
 
;(check-expect
;  (get '(meta ((content "+0.11") (itemprop "delta"))) "delta")
;  "+0.11")
;(check-expect
;  (get '(meta ((itemprop "price") (content "17.01"))) "price")
;  "17.01")
;(check-error
;  (get '(meta ((itemprop "price") (content "17.01"))) "delta")
;  "attribute not found: delta")
 
(define (get x s)
  (local ((define result (get-xexpr x s)))
    (if (string? result)
        result
        (error (string-append "attribute not found: " s)))))

(define (get-xexpr x s) x)