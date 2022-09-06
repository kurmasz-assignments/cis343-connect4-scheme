(require 'regex)


(define (int-to-char i)
  (integer->char (+ i 65))
)

(define (string-to-int s)
  (- (char->integer (string-ref s 0)) 65)
)

; Parse the size parameter, which should look something like 5x7
(define (parse-size size)
  ; the regex-match will generate a list of three elements:
  ; * The entire string
  ; * The first parens
  ; * The second parens
  ; The call to cdr removes the first item from the list.
  (define result (cdr (regex-match  #/(\d+)x(\d+)/ size)))

  ; If the pattern doesn't match, print a message and quit.
  (cond
    ((not result) (display (format "\"~A\" is not a valid board size" size)) (exit))
    (else (map (lambda (x) (string->number x)) result))
  )
)

; Parse the win_length parameter, which should be an integer.
(define (parse-win-length win_length)
 (define result (regex-match #/\d+/ win_length))
 (cond 
  ((not result) (display (format "\"~A\" is not a valid win length" win_length)) (exit))
  (else (string->number win_length))
 )
)

(define (play-connect-4 num_rows num_columns win_length)
    ; TODO:  Load the .scm file containing your connect 4 code 
    ; Then launch a connect4 game.
    (include-relative "connect4_engine.scm")

    ; Your function does not need to be named "connect4-game"
    ((car (connect4-game num_rows num_columns win_length)))
)

(define num_args (vector-length command-line-arguments))
(cond 
  ((= 0 num_args) (play-connect-4 6 7 4))  ; play a default 6x7 game of Connect 4.
  ((= 1 num_args) (apply play-connect-4 (append (parse-size (vector-ref command-line-arguments 0)) (list 4))))
  (else (apply play-connect-4 (append (parse-size (vector-ref command-line-arguments 0)) (list (parse-win-length (vector-ref command-line-arguments 1))))))
)