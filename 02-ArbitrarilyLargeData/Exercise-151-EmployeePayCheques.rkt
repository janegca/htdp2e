;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-151-EmployeePayCheques) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
; Exercise 151. 
;
; The wage*.v2 function consumes a list of work records and produces a list 
; of numbers. Of course, functions may also produce lists of structures.
;
; Develop a data representation for pay checks. Assume that a pay check 
; contains two pieces of information: the name of the employee and an amount.
; Then design the function wage*.v3. It consumes a list of work records and
; computes a list of (representations of) pay checks from it, one per work 
; record.
;
; In reality, a pay check also contains an employee number. Develop a data 
; representation for employee information and change the data definition for 
; work records so that it uses employee information and not just a string for
; the employee’s name. Also change your data representation of pay checks so 
; that it contains an employee’s name and number, too. Finally, design 
; wage*.v4, a function that maps lists of revised work records to lists of 
; revised pay checks.
;
; Note This exercise demonstrates the iterative refinement of a task. 
; Instead of using data representations that include all relevant information,
; we started from simplistic representation of pay checks and gradually made
; the representation realistic. For this simple program, refinement is 
; overkill; later we will encounter situations where iterative refinement is 
; not just an option but a necessity.

;-- Data Structures
(define-struct paycheck [employee amount])
; Paycheck is a structure: (make-paycheck String Number)
; interpretation: (make-paycheck n a) combines an employee name (n)
; with the amount they are to be paid (a) for their work

; Loc (List of checks) is one of:
; - '() and empty list
; - (cons Paycheck Loc)
; intepretation: an instance of Loc represents a list of
; employee paychecks

(define-struct work [employee rate hours])
; Work is a structure: (make-work String Number Number). 
; interpretation (make-work n r h) combines the name (n) 
; with the pay rate (r) and the number of hours (h) worked.

; Low (list of works) is one of:
; – '()
; – (cons Work Low)
; interpretation an instance of Low represents the work efforts
; of some hourly employees


;-- Functions
; List-of-works -> List-of-checks
(check-expect (wage*.v3 (cons (make-work "Robby" 11.95 39) '()))
              (cons (make-paycheck "Robby" (* 11.95 39)) '()))

(define (wage*.v3 low)
  (cond
    ([empty? low] '())
    ([cons?  low]
     (cons (check (first low))
           (wage*.v3 (rest low))))))

; Work -> Paycheck
; create an employee paycheck from a work record
(define (check w)
  (make-paycheck (work-employee w)
                 (wage.v2 w)))
            
; Work -> Number
; computes the wage for the given work record w
(define (wage.v2 w) 
  (* (work-rate w) (work-hours w)))            

; -- Revised definitions

(define-struct employee [name id])
; An Employee is a structure: (make-employee String Number)
; interpretation: (make-employee n id) combines and employee
; name (n) and identification number (id)
  
(define-struct work.v2 [employee rate hours])
; Work is a structure: (make-work Employee Number Number). 
; interpretation (make-work n r h) combines the employee record (e) 
; with the pay rate (r) and the number of hours (h) worked.
  
(define-struct paycheck.v2 [name id amount])
; Paycheck is a structure: (make-paycheck String Number Number)
; interpretation: (make-paycheck n id a) combines an employee name (n) and
; identification number (id) with the amount they are to be paid (a) for
; their work
    
; List-of-works -> List-of-checks
(check-expect (wage*.v4 (cons (make-work
                               (make-employee "Robby" 100)
                               11.95 39) '()))
              (cons (make-paycheck.v2 "Robby" 100 (* 11.95 39)) '()))

(define (wage*.v4 low)
  (cond
    ([empty? low] '())
    ([cons?  low]
     (cons (check.v2 (first low))
           (wage*.v4 (rest low))))))

; Work -> Paycheck
; create an employee paycheck from a work record
(define (check.v2 w)
  (make-paycheck.v2 (employee-name (work-employee w))
                    (employee-id   (work-employee w))
                    (wage.v2 w)))
