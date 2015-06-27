;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname Exercise-366-Hangman) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ())))
; Exercise 366.
;
; Hangman is a well-known guessing game. One player picks a word, the other
; player gets told how many letters the word contains. The latter picks a
; letter and asks the first player whether and where this letter occurs in
; the chosen word. The game is over after an agreed-upon time or number of
; rounds.
;
; Figure 89 presents the essence of a time-limited version of the game.
; See ... Add Expressive Power for why checked-compare is defined locally.
;
; The goal of this exercise is to design compare-word, the central function.
; It consumes the word to be guessed, a word that represents how much/little
; the guessing player has discovered, and the current guess. The function
; produces a word, revealing whether the guess occurred in the word and,
; if so, where.
;
; Once you have designed the function, you can run the program, say like this:
;
;    (define DICTIONARY-LOCATION "/usr/share/dict/words") ; on Mac OS X
;    (define DICTIONARY-AS-LIST (read-lines DICTIONARY-LOCATION))
;    (define DICTIONARY-SIZE (length DICTIONARY-AS-LIST))
;     
;    (play (list-ref DICTIONARY-AS-LIST (random DICTIONARY-SIZE)) 10)
;
; See figure 48 for an explanation. Enjoy and refine as desired!

; POSSIBLE TODO's:
;   1. modify to limit on # of guesses vs timed limit
;   2. modify graphics to space out letters ie "_ a _ _" vs "_a__"
;   3. add a 'lost' 'won' final screen that displays the word if
;      you lose

(require 2htdp/batch-io)
(require 2htdp/image)
(require 2htdp/universe)

(define DICTIONARY-LOCATION "../02-ArbitrarilyLargeData/words.txt")
(define DICTIONARY-AS-LIST (read-lines DICTIONARY-LOCATION))
(define DICTIONARY-SIZE (length DICTIONARY-AS-LIST))

; A HM-Word is [List-of [Maybe Letter]]
; interpretation #false represents a letter to be guessed 
; A Letter is member? of LETTERS.
(define LETTERS (explode "abcdefghijklmnopqrstuvwxyz"))

; HM-Word N -> String
; run a simplistic Hangman game, produce the current state of the game
; assume the-pick does not contain #false
(define (play the-pick time-limit)
  (local ((define the-word  (explode the-pick))
          (define the-guess (make-list (length the-word) "_"))
          
          ; HM-Word -> Image
          ; render the word
          (define (render-word w)
            (text (implode w) 22 "black"))
          
          ; HM-Word -> HM-Word
          (define (do-nothing s) s)
          
          ; HM-Word KeyEvent -> HM-Word 
          (define (checked-compare current-status ke)
            (if (member? ke LETTERS)
                (compare-word the-word current-status ke)
                current-status))
          
          ; HM-Word HM-Word KeyEvent -> HM-Word
          (define (compare-word w c ke)
            (cond [(empty? w) c]
                  [(equal? ke (first w))
                   (cons ke (compare-word (rest w) (rest c) ke))]
                  [else (cons (first c) (compare-word (rest w) (rest c) ke))])))
    
    ; the state of the game is a HM-Word
    (implode
     (big-bang the-guess
               [to-draw render-word]
               [on-tick do-nothing 1 time-limit]
               [on-key  checked-compare]))))

; -- example usage
(play (list-ref DICTIONARY-AS-LIST (random DICTIONARY-SIZE)) 10)
