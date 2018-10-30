(define strom '(25 (15 () ()) (30 () ())))

(define search
  (lambda (strom number)
    (cond ((null? strom) (display "Prvek nenalezen"))
          ((= number (car strom)) (display "prvek nalezen"))
          ((< number (car strom)) (search (cadr strom) number))
		  ((> number (car strom)) (search (caddr strom) number)))))

(search strom 25)

(define insert
  (lambda (strom number)
    (cond ((null? strom) (cons (list number () ()) strom))
          ((< number (car strom)) (search (cadr strom) number))
		  ((> number (car strom)) (search (caddr strom) number)))))


(newline)
(insert strom 10)


(define x 10)
(define y 10)

(define cat (list x y))
(define dog (list y x))

(display (equal? cat dog))




          