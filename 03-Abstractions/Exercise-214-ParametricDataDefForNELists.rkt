;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname Exercise-214-ParametricDataDefForNELists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 214. 
;
; Compare and contrast the data definitions for NEList-of-temperatures and 
; NEList-of-Booleans. Then formulate an abstract data definition NEList-of. 

; A NEList-of-temperatures is one of: 
; – (cons CTemperature '())
; – (cons CTemperature NEList-of-temperatures)
; interpretation non-empty lists of measured temperatures 

; An NEList-of-Booleans is one of:
; - (cons Boolean '())
; - (cons Boolean NEList-of-Booleans)
; interpretation: a non-empty List-of-Booleans represents a list of
; true and/or false values with at least one value

; A NEList-of ITEM is one of:
; - (cons ITEM '())
; - (cons ITEM [NEList-of ITEM])

