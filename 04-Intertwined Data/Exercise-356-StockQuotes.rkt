;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-356-StockQuotes) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 356.
;
; Look up the current stock price for your favorite company at Google’s
; financial service page. If you don’t favor a company, pick Ford. Then save
; the source code of the page as a file in your working directory.
;
; Use read-xexpr in DrRacket to view the source as an Xexpr.v3.

(require 2htdp/batch-io)

(read-xexpr "finance.htm")

; NOTE: 2015-06-26 page read produces an error, given a 0 in when
;                  expecting a symbol or valid character
