;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-359-wages) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 359.
;
; In the real world, wages*.v2 consumes lists of employee structures and lists
; of work records. An employee structure contains an employee’s name, social
; security number, and pay rate. A work record also contains an employee’s
; name and the number of hours worked in a week. The result is a list of
; structures that contain the name of the employee and the weekly wage.
;
; Modify the program in this section so that it works on these realistic
; versions of data. Provide the necessary structure type definitions and
; data definitions. Use the design recipe to guide the modification process.

(define-struct employee [name sin rate])
; An Employee is a structure: (make-employee String Number Number)
; interpretation: (make-employee name sin rate) combines an employee name,
; social insurance number (sin) and pay rate (rate)

(define-struct record [name hours])
; A Record is a structure: (make-record String Number)
; interpretation: (make-record name hours) combines an employee's name
; and the number of hours worked in a week.

; A Wage is: '(name wage)

; A [List-of Wage] is one of:
; '()
; (cons Wage [List-of Wage])

; [List-of Employee] [List-of Record] -> [List-of Wage]
; computes weekly wages by multiplying the corresponding rate and hours
; in the items on employees and record
; assume the two lists are ordered on name and of equal length
(check-expect (wages* '() '()) '())
(check-expect (wages* `(,(make-employee "John" 123445 25))
                      `(,(make-record   "John" 35.5)))
              `(("John" ,(* 25 35.5))))
(check-expect (wages* `(,(make-employee "John"  123445 25)
                        ,(make-employee "Ringo" 123456 23))
                      `(,(make-record   "John"  30)
                        ,(make-record   "Ringo" 35)))
             `(("John" ,(* 25 30)) ("Ringo" ,(* 23 35))))
              
(define (wages* emp* rec*)
  (cond
    [(empty? emp*) '()]
    [else (cons (weekly-wage (first emp*) (first rec*))
                (wages* (rest emp*) (rest rec*)))]))

; Employee Record -> Wage
; computes the weekly wage from pay-rate and hours-worked
; assume employee name is the same in both data strucutres
(define (weekly-wage emp rec)
  (list (employee-name emp)
        (* (employee-rate emp) (record-hours rec))))

