(define length
  (lambda (l)
    (if (null? l)
        0
        (+ 1 (length (cdr l))))))

(let lentx ((l '(5 4 6)))
   (if (null? l)
        0
        (+ 1 (lentx (cdr l)))))

(length '(5 6 4))

(define append
  (lambda (l1 l2)
    (if (null? l1)
        l2
        (cons (car l1) (append (cdr l1) l2)))))

(append '(1 2 3) '(4))

(define expt
  (lambda (x n)
    (if (= n 0)
        1
        (* x (expt x (- n 1))))))
(expt 5 2)

(define extp1
  (lambda (x n)
    (cond ((= n 0) 1)
          ((even? n)
           (let ((resault (expt x (/ n 2))))
             (* resault resault)))
             (else (* x (expt x (- n 1)))))))
(extp1 2 4)


(define fac-iter
  (lambda (accum i)
    (if (<= i 1)
        accum
        (fac-iter (* accum i) (- i 1)))))

(define fac
  (lambda (n)
    (fac-iter 1 n)))

(define fax
  (lambda (n)
    (let iter ((accum 1)
               (i n))
      (if (<= i 1)
        accum
        (fac-iter (* accum i) (- i 1))))))

(fax 1)

(define delka
  (lambda (l)
    (let delka-iter ((l l)
                     (accum 0))
      (if (null? l)
          accum
          (delka-iter (cdr l) (+ accum 1))))))

(delka '(1 2 3))

(let proc ((n 10))
  (if (= n 0)
      0
      (+ n (proc ( - n 1)))))

(define prox
  (lambda (n)
    (if (= n 0)
        0
        (+ n (prox (- n 1))))))
(prox 10)


(or 4 5 1 #f)


(define ornf
  (lambda values
    (if (null? values)
        #f
     (if (car values)
         (car values)
         (apply ornf (cdr values))))))


(ornf 4 5 1 #f)

(and 1 5 4 1 #f)

(define andf
  (lambda values
    (if (null? values)
        #t
    (if (car values)
        (apply andf (cdr values))
        #f))))

(andf 5 4 1)


(define dropf
  (lambda (l pred)
    (if (null? l)
        l
     (if (pred (car l))
         (dropf (cdr l) pred)
         ((lambda () (append (list (car l))
                           (dropf (cdr l) pred))))))))

(dropf '(1 2 3 4 5 6 7 8 9) even?)

(define takef
  (lambda (l pred)
    (if (null? l)
        l
     (if (pred (car l))
         ((lambda () (append (list (car l))
                           (takef (cdr l) pred))))
         (takef (cdr l) pred)))))

(define takeff
  (lambda (l pred)
    (if (null? l)
        l
     (if (pred (car l))
         (cons (append (list (car l)))
          (takef (cdr l) pred))))
         (takef (cdr l) pred)))


(takef '(1 2 3 4 5 6 7 8 9) even?)
(takeff '(1 2 3 4 5 6 7 8 9) even?)