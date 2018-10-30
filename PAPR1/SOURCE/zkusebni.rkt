(define proc
  (lambda (x list)
    (cons x list)))

(proc 'x '(1 2 3))

(define exps
  (lambda (s)
    (foldr (lambda (x y)(expt x y)) 0 s)))

(exps '(2 3 4))

(define lengthh
  (lambda (x)
    (foldr (lambda (x y) (+ 1 y)) 0 x)))

(define pros
  (lambda (p l)
    (if (null? l)
        l
        (cond ((equal? p (car l)) l)
              ((< p (car l)) (apply pros (cdr l)))
              (else (cons p (cdr l)))))))
            

(pros 4 '(1 2 5 6))

(foldr cons '() '(1 2 3))

(define map1
  (lambda (f l)
    (foldr (lambda (x y)
             (cons (f x) y))
           '()
           l)))

(map1 + '(1 2))

(not (cons '() 4))

(define member??
  (lambda (elem l)
    (foldr (lambda (x y)
             (if (equal? x elem)
                 #t
                 y))
           #f
           l)))

(member?? 1 '(1 2 3))


(define lam
  (lambda (l)
    (foldr (lambda (x y)
             (expt x (+ 1 y)))
           0
           l)))

(lam '(5 5))

(define member?
  (lambda (elem l)
    (not (null? (filter
                 (lambda (x)
                   (equal? x elem))
                 l)))))

(define union
  (lambda (l1 l2)
    (foldr (lambda (x y)
             (if (member? x y)
                 y
                 (cons x y)))
            l2
            l1)))

(union '(1 2 3) '(3 4 5))

(define fact
  (lambda (cislo)
    (foldr *
           1
           (build-list cislo (lambda (x) (+ 1 x))))
           ))
(fact 5)

(define prov
  (lambda (l)
    (foldl (lambda (x y)
             (cons x y))
           '()

           l)))

(prov '(1 2 3 4))

(car '(1))

(apply + '(0 1))

(cadr '(8 5))

(cadr (cons '(1 2) (cons 3 4)))

    