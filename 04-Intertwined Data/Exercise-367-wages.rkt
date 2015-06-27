;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-367-wages) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 367.
;
; In a factory, employees punch time cards as they arrive in the morning and
; leave in the evening. Electronic punch cards contain an employee number and
; record the number of hours worked per week. Employee records always contain
; the name of the employee, an employee number, and a pay rate.
;
; Design wages*.v3. The function consumes a list of employee records and a
; list of punch-card records. It produces a list of wage records, which
; contain the name and weekly wage of an employee. The function signals an
; error if it cannot find an employee record for a punch-card record or vice
; versa.
;
; You may assume that there is at most one punch-card record per employee
; number. An actual accounting program ensures that such assumptions hold.

(define-struct employee [name id rate])
; An Employee is a structure: (make-employee String Number Number)
; interpretation: (make-employee name id rate) combines an employee name,
; employee number (id) and hourly pay rate (rate).

(define-struct epc [empid hours])
; An Electronic Punch Card (epc) is a structure:
; (make-epc Number Number)
; interpretation: (make-epc empid hours) combines an employee number (empid)
; with the hours worked in a week (hours)

(define-struct wage [empid amount])
; A Wage is a structure: (make-wage Number Number)
; interpretation: (make-wage empid amount) combines an employee number (empid)
; with an earned wage (amount).

; -- Example employee and punch cards lists
(define e0 `(,(make-employee "Harpo"   100  18)
             ,(make-employee "Groucho" 101  19)
             ,(make-employee "Zeppo"   102  15)
             ,(make-employee "Chico"   103  17)
             ,(make-employee "Gummo"   104  16)))

(define w0 `(,(make-epc 100 10)
             ,(make-epc 101 10)
             ,(make-epc 102 10)
             ,(make-epc 103 10)
             ,(make-epc 104 10)))

; [List-of Employee] [List-of EPC] -> [List-of Wage]
; the wages earned by each employee in the given week
; assume both lists are sorted by employee number and there is
;        only one punch card record per employee
(check-expect (wages e0 w0)
              `(,(make-wage 100 180)
                ,(make-wage 101 190)
                ,(make-wage 102 150)
                ,(make-wage 103 170)
                ,(make-wage 104 160)))

(check-error (wages `(,(make-employee "John" 300 20))
                    `(,(make-epc 100 10))))

(define (wages emp* epc*)
  (local ((define (mismatched-ids? emp epc)
            (not (eq? (employee-id emp) (epc-empid epc))))

          (define (pay emp epc)
            (make-wage (epc-empid epc)
                       (* (employee-rate emp)
                          (epc-hours     epc)))))
    
  (cond [(empty? emp*) '()]
        [(mismatched-ids? (first emp*) (first epc*))
         (error 'wages "records out of sync")]
        [else
         (cons (pay (first emp*) (first epc*))
               (wages (rest emp*) (rest epc*)))])))

              
