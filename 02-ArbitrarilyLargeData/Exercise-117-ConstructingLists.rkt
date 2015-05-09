;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname Exercise-117-ConstructingLists) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 117. Create BSL lists that represent
;
;   a list of celestial bodies, say, at least all the planets in our solar 
;   system
;
;   a list of items for a meal, for example, steak, French fries, beans, 
;   bread, water, brie cheese, and ice cream; and
;
;   a list of colors.
;
(cons "Sun" 
      (cons "Moon"
            (cons "Mercury"
                  (cons "Venus"
                        (cons "Earth"
                              (cons "Mars"
                                    (cons "Jupiter"
                                          (cons "Saturn"
                                                (cons "Uranus"
                                                      (cons "Neptune"
                                                            (cons "Pluto"
                                                                  '()
                                                                  )))))))))))


(cons "steak"
      (cons "French fries"
            (cons "beans"
                  (cons "bread"
                        (cons "water"
                              (cons "brie"
                                    (cons "cheese"
                                          (cons "ice cream"
                                                '() ))))))))

(cons "red"
      (cons "blue"
            (cons "green"
                  (cons "yellow"
                        (cons "violet"
                              (cons "cyan"
                                    '() ))))))
