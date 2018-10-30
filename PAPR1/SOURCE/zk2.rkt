(define min2
  (lambda (x y)
    (if (< x y)
        x
        y)))

(define proc
  (lambda values
    (foldr (lambda (x y)
             (if (< x y)
                 x
                 y))
             (car values)
             values)))

(proc 4 5 6 8 7)

(define nondecreasing?
  (lambda (l)
    (foldr (lambda (x y)
             (if y
                 (if (or (equal? y #t) (<= x y))
                     x
                     #f)
                 #f))
           #t
           l)))

(nondecreasing? '(1 2 3 4))


(define fac
  (lambda (n)
    (if (<= n 1)
        1
        (* n (fac (- n 1))))))

(fac 4)

(define fac-iter
  (lambda (n)
    (let iter ((i n)
               (accum 1))
      (if (<= i 1)
          accum
          (iter (- i 1) (* accum i))))))

(fac-iter 5)

(define fab
  (lambda (n)
    (if (<= n 1)
        n
        (+ (fab (- n 1)) (fab (- n 2))))))

(define fib-iter
  (lambda (n)
    (let iter ((accum 0)
               (b 1)
               (i n))
      (if (= i 0)
          accum
          (iter b (+ accum b) (- i 1))))))
(fib-iter 5)
      

(display 'FIB)
(display "\n")

(fab 4)
(define fib
  (lambda (n)
    (cadr
     (foldr (lambda (x last)
              (list (apply + last) (car last)))
            '(1 0)
            (build-list n (lambda (x) #f))))))
(fib 50)
(define lenght
  (lambda (l)
    (if (null? l)
        0
        (+ 1 (lenght (cdr l))))))

(lenght '(4 5 1 6 8))

(define app
  (lambda (l1 l2)
    (if (null? l1)
        l2
        (cons (car l1) (app (cdr l1) l2)))))

(app '(1 2 3) '(4 5 6))


(define expt
  (lambda (x n)
    (if (= n 0)
        1
        (* x (expt x (- n 1))))))

(expt 3 2)




(define na2
  (lambda (x) (* x x)))

(define ex
  (lambda (x n)
    (if (= n 0)
        1
        (if (even? n)
            (na2 (ex x (/ n 2)))
            (* x (ex x ( - n 1)))))))

(ex 2 4)
    

(define expt-iter
  (lambda (x n)
    (let iter ((i n)
               (accum 1))
      (if (= i 0)
          accum
      (iter (- i 1) (* x accum ))))))

(expt-iter 2 7)

(define length-iter
  (lambda (n)
    (let iter ((i n)
               (accum 0))
      (if (null? i)
          accum
          (iter (cdr i) (+ accum 1))))))

(length-iter '(4 5 1 6))

(define take
  (lambda (n l)
    (if (= n 0)
        l
        (take (- n 1) (cdr l)))))

(take 2 '(1 2 3 4 5))

(define mapp
  (lambda (f l)
    (if (null? l)
        '()
        (cons (f (car l))
              (map f (cdr l))))))
    
(mapp - '(1 2 3))

(define buildlist
  (lambda (n f)
    (let iter ((accum 0))
      (if (= n accum)
          '()
          (cons (f accum)
                (iter (+ accum 1)))))))

(buildlist 10 *)

(define rever
  (lambda (l)
    (if (null? l)
        '()
        (append (reverse (cdr l))
                (list (car l))))))
(rever '(1 2 3))

(define reverse-iter
  (lambda (l)
    (let iter ((accum '())
              )
      (if (null? l)
          accum
          (iter ())))))

(reverse-iter '(1 2 3))

(define adjoin
  (lambda (n l)
    (if (null? l)
        '()
        (+ 1 (adjoin n (cdr l)))
       )))
                     

(adjoin 2 '(1 3 4 5))

(+ 1 2)      