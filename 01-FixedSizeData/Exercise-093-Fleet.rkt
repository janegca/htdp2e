;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname Exercise-093-Fleet) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 93. 
; The administration of your home town manages a fleet of vehicles:
; automobiles, vans, buses, SUVs, and trucks. Develop a data representation 
; for vehicles. The representation of each vehicle must describe the number 
; of passengers that it can comfortably accommodate, its license plate, and 
; its fuel consumption (miles per gallon).
;
; Develop a template for functions that consume representations of vehicles. 

; A Vtype is one of the following strings:
;  - automobile
;  - van
;  - bus
;  - SUV
;  - truck

(define-struct vehicle [vtype passengers license mpg])
; is (make-vehicle String Number String Number)
; interpretation: (make-vehicle type passengers license mpg) is a vehicle
; type that can hold so many passengers, has a specific license plate number
; and gets so many miles per gallon of fuel
;
;  ( ... (vehicle-vtype v)   ... (vehicle-passengers v) ...
;    ... (vehicle-license v) ... (vehicle-mpg v) ... )

