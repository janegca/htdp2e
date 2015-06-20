;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-331-XexprAsXML) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 331. 
; 
; Interpret the following elements of Xexpr.v2 as XML data:
;
; 1.  '(server ((name "example.org")))
; 2.  '(carcassonne (board (grass)) (player ((name "sam"))))
; 3.  '(start)
;
; Which ones are elements of Xexpr.v0 or Xexpr.v1?

; 1.  '(server ((name "example.org")))
;
;    <server name="example.org"></server>

; 2.  '(carcassonne (board (grass)) (player ((name "sam"))))
;
;     <carcassonne>
;          <board> <grass /> </board>
;          <player name="sam"> </player>
;    </carcassonne>

; 3.  '(start)
;
;        <start />

; Ans:
;    3 could be represented by Xexpr.0 and Xexpr.v1
