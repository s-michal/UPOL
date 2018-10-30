(define drop
  (lambda (list n)
    (if (or (= n 0) (< n 0))
        list
        (drop (cdr list) (- n 1)))))

(drop '(4 5 1 3 5 4 6 9) 4)


(define take
  (lambda (l n)
    (if (= n 0)
        '()
        (append (list (car l))(take (cdr l) (- n 1))))))

(take '(4 5 1 3 5) 2)

;(define orfn
 ; (lambda values
  ;  (if ())))


;(orfn '(#f 5 #f 4 #f))

(define moc
  (lambda (x n)
    (if (= n 0)
        1
        (* x (expt x (- n 1))))))

(moc 2 3)

(define len
  (lambda (list)
    (if (null? list)
        '()
        (+ 1 (len (cdr list))))))

(len '(1 5 4 6))