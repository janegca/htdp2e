;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-408-evaluatingQuickSort) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 408. Evaluate
;
;    (quick-sort (list 10 6 8 9 14 12 3 11 14 16 2))
;
; by hand. Show only those lines that introduce a new recursive call to
; quick-sort. How many recursive applications of quick-sort are required?
; How many recursive applications of the append function? Suggest a general
; rule for a list of length n.
;
; [NOTES (based on evaluations)
;      An unsorted list may take roughly 1.5n
;      while a sorted list requires (2n - 1) operations
;
; Evaluate
;
;   (quick-sort (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14))
;
; by hand. How many recursive applications of quick-sort are required? How
; many recursive applications of append? Does this contradict the first part
; of the exercise?

(quick-sort (list 10 6 8 9 14 12 3 11 14 16 2))
==
(append (quick-sort (6 8 9 3 2))
        '(10)
        (quick-sort (14 12 11 14 16))))
==
(append
 (append (quick-sort (3 2))
         '(6)
         (quick-sort (8 9)))
 '(10)
 (quick-sort (14 12 11 14 16)))
==
(append
 (append
  (append (quick-sort (2))
          '(3)
          (quick-sort '()))
         '(6)
         (quick-sort (8 9)))
 '(10)
 (quick-sort (14 12 11 14 16)))
==
(append
 (append
  (append (quick-sort (2))
          '(3)
          (quick-sort '()))
         '(6)
         (append (quick-sort '())
                 '(8)
                 (quick-sort (9))))
 '(10)
 (quick-sort (14 12 11 14 16)))
==
(append
 (append
  (append (quick-sort (2))
          '(3)
          (quick-sort '()))
         '(6)
         (append (quick-sort '())
                 '(8)
                 (quick-sort (9))))
 '(10)
 (append (quick-sort (12 11))
        '(14)
         (quick-sort (14 16))))
==
(append
 (append
  (append (quick-sort (2))
          '(3)
          (quick-sort '()))
         '(6)
         (append (quick-sort '())
                 '(8)
                 (quick-sort (9))))
 '(10)
 (append
  (append (quick-sort (11))
          '(12)
          (quick-sort '()))
  '(14)
  (quick-sort (14 16))))
==
(append
 (append
  (append (quick-sort (2))
          '(3)
          (quick-sort '()))
         '(6)
         (append (quick-sort '())
                 '(8)
                 (quick-sort (9))))
 '(10)
 (append
  (append (quick-sort (11))
          '(12)
          (quick-sort '()))
  '(14)
  (append (quick-sort '())
          '(14)
          (quick-sort (16)))))
==
(append
 (append (append '(2) '(3)) '(6) (append '(8) '(9)))
 '(10)
 (append (append '(11)'(12)) '(14) (append '(14) '(16))))

; Answer:  8 calls to quick-sort
;          7 calls to append
;          so an unsorted list will take roughly 1.5n operations
;
(quick-sort (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14))
==
(append (quick-sort '())
        '(1)
        (quick-sort '( 2 3 4 5 6 7 8 9 10 11 12 13 14)))
==
(append (quick-sort '())
        '(1)
        (append (quick-sort '())
                '(2)
                (quick-sort '(3 4 5 6 7 8 9 10 11 12 13 14))))
==
(append (quick-sort '())
        '(1)
        (append (quick-sort '())
                '(2)
                (append (quick-sort '())
                        '(3)
                        (quick-sort '(4 5 6 7 8 9 10 11 12 13 14)))))
==
(append (quick-sort '())
        '(1)
        (append (quick-sort '())
                '(2)
                (append (quick-sort '())
                        '(3)
                        (append (quick-sort '())
                                '(4)
                                (quick-sort '(5 6 7 8 9 10 11 12 13 14))))))
==
(append
 (quick-sort '())
 '(1)
 (append
  (quick-sort '())
  '(2)
  (append
   (quick-sort '())
   '(3)
   (append
    (quick-sort '())
    '(4)
    (append
     (quick-sort '())
     '(5)
     (quick-sort '(6 7 8 9 10 11 12 13 14)))))))
==
(append
 (quick-sort '())
 '(1)
 (append
  (quick-sort '())
  '(2)
  (append
   (quick-sort '())
   '(3)
   (append
    (quick-sort '())
    '(4)
    (append
     (quick-sort '())
     '(5)
     (append
      (quick-sort '()) '(6) (quick-sort '(7 8 9 10 11 12 13 14))))))))
==
(append
 (quick-sort '())
 '(1)
 (append
  (quick-sort '())
  '(2)
  (append
   (quick-sort '())
   '(3)
   (append
    (quick-sort '())
    '(4)
    (append
     (quick-sort '())
     '(5)
     (append
      (quick-sort '()) '(6)
      (append (quick-sort '()) '(7) (quick-sort '(8 9 10 11 12 13 14)))))))))
==
(append
 (quick-sort '())
 '(1)
 (append
  (quick-sort '())
  '(2)
  (append
   (quick-sort '())
   '(3)
   (append
    (quick-sort '())
    '(4)
    (append
     (quick-sort '())
     '(5)
     (append
      (quick-sort '()) '(6)
      (append
       (quick-sort '()) '(7)
       (append (quick-sort '()) '(8) (quick-sort '(9 10 11 12 13 14))))))))))
==
(append
 (quick-sort '())
 '(1)
 (append
  (quick-sort '())
  '(2)
  (append
   (quick-sort '())
   '(3)
   (append
    (quick-sort '())
    '(4)
    (append
     (quick-sort '())
     '(5)
     (append
      (quick-sort '()) '(6)
      (append
       (quick-sort '()) '(7)
       (append
        (quick-sort '()) '(8)
        (append (quick-sort '()) '(9) (quick-sort '(10 11 12 13 14)))))))))))
==
(append
 (quick-sort '())
 '(1)
 (append
  (quick-sort '())
  '(2)
  (append
   (quick-sort '())
   '(3)
   (append
    (quick-sort '())
    '(4)
    (append
     (quick-sort '())
     '(5)
     (append
      (quick-sort '()) '(6)
      (append
       (quick-sort '()) '(7)
       (append
        (quick-sort '()) '(8)
        (append
         (quick-sort '()) '(9)
         (append (quick-sort '()) '(10) (quick-sort '(11 12 13 14))))))))))))
==
(append
 (quick-sort '())
 '(1)
 (append
  (quick-sort '())
  '(2)
  (append
   (quick-sort '())
   '(3)
   (append
    (quick-sort '())
    '(4)
    (append
     (quick-sort '())
     '(5)
     (append
      (quick-sort '()) '(6)
      (append
       (quick-sort '()) '(7)
       (append
        (quick-sort '()) '(8)
        (append
         (quick-sort '()) '(9)
         (append
          (quick-sort '()) '(10)
          (append (quick-sort '(11)) (quick-sort '(12 13 14)))))))))))))
==
(append
 (quick-sort '())
 '(1)
 (append
  (quick-sort '())
  '(2)
  (append
   (quick-sort '())
   '(3)
   (append
    (quick-sort '())
    '(4)
    (append
     (quick-sort '())
     '(5)
     (append
      (quick-sort '()) '(6)
      (append
       (quick-sort '()) '(7)
       (append
        (quick-sort '()) '(8)
        (append
         (quick-sort '()) '(9)
         (append
          (quick-sort '()) '(10)
          (append
           (quick-sort '()) '(11)
           (append (quick-sort '()) '(12) (quick-sort '(13 14))))))))))))))
==
(append
 (quick-sort '())
 '(1)
 (append
  (quick-sort '())
  '(2)
  (append
   (quick-sort '())
   '(3)
   (append
    (quick-sort '())
    '(4)
    (append
     (quick-sort '())
     '(5)
     (append
      (quick-sort '()) '(6)
      (append
       (quick-sort '()) '(7)
       (append
        (quick-sort '()) '(8)
        (append
         (quick-sort '()) '(9)
         (append
          (quick-sort '()) '(10)
          (append
           (quick-sort '()) '(11)
           (append
            (quick-sort '()) '(12)
            (append (quick-sort '()) '(13) (quick-sort '(14)))))))))))))))
==
(append
 (quick-sort '())
 '(1)
 (append
  (quick-sort '())
  '(2)
  (append
   (quick-sort '())
   '(3)
   (append
    (quick-sort '())
    '(4)
    (append
     (quick-sort '())
     '(5)
     (append
      (quick-sort '()) '(6)
      (append
       (quick-sort '()) '(7)
       (append
        (quick-sort '()) '(8)
        (append
         (quick-sort '()) '(9)
         (append
          (quick-sort '()) '(10)
          (append
           (quick-sort '()) '(11)
           (append
            (quick-sort '()) '(12)
            (append
             (quick-sort '()) '(13)
             (append '(14)))))))))))))))

; Answer: 13 calls to quick-sort
;         14 calls to append
;         disagrees with conclusion from first exercise;
;         here we needed (2n - 1) operations
                                                                               


