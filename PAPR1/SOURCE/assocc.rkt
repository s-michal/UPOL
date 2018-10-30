(quote (5 (+ 1 2) 6))
(quasiquote (5 ,(+ 1 2) 6))
(quasiquote (1 unquote (+ 1 2)))
`(1 2 ,(list '(3)))
`(1 2 ,(list `(3)))
'`(1 2 3)

`(4 5 ,@((lambda () (map (lambda (x) (+ x 10)) `(1 ,(+ 1 3))))) 6)

(define ==
  (lambda (x y)
    (and (= x y) (number? y) (number? x))))

(== 5 4)

(define assoc
  (lambda (elem l)
    (cond ((null? l) l)
          ((equal? elem (caar l)) (car l))
          (else (assoc elem (cdr l))))))


(assoc 'a '((a . 10) (b . (a b c)) (20 30) (b . 666)))

(- (/ (+ 5 2) 6))

((lambda x (list (car x) x (cdr x))) 5 6)

((lambda x (list x x)) (list 1 2 3))

(list '(1 2 3) '(1 2 3))

(map cons (list '+ 3) (cons 'a '(b)))

(cons (cons '+ 'a) (cons (cons 3 'b) '()))

(cons (cons (cons 1 (cons 2 (cons 3 '()))) '())
      (cons (cons (cons 1 (cons 2 (cons 3 '()))) '()) '()))

(cons (cons 1 '()) (cons 3 (list '() 1)))

(let ((a (list 'a)))
  (cons a a))

(cons (cons 'a '()) (cons 'a '()))


(define list-pref (lambda (n l) (if (<= n 0) '() (cons (car l) (list-pref (- n 1) (cdr l))))))


(display "LISTPREF")
(display "\n")

(list-pref 3 '(4 5 6 1))
(list-ref '(4 5 6 1) 3)
(map apply (list list) '((#t #f)))
