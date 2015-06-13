;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname 2303-Examples-UsingHtdpDirPkg) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; 23.03 - Example - Using htdp/dir package

(require htdp/dir)

;(define d0 (create-dir "/Users/...")) ; on OS X 
;(define d1 (create-dir "/var/log/")) ; on OS X 
;(define d2 (create-dir "C:\\Users\\...")) ; on Windows 

; on Windows, following return Dir.v3 structures populated with
; directory contents
(define d3 (create-dir "c:\\save"))
(define d4 (create-dir "c:\\Users\\Jane\\Documents\\Articles"))

; string sentence as a symbol
(define exstr '|Does this work?|)  ; yes