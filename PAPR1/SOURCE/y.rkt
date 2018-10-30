(define append2
  (lambda (l1 l2)
    (if (null? l1)
        l2
        (cons (car l1) (append2 (cdr l1) l2)))))

(append2 '(1 5 4) '(1 2 3 6 4 8))

(define list-reff
  (lambda (l i)
    (if (= i 0)
        (car l)
        (list-reff (cdr l) (- i 1)))))
  
(list-reff '(4 5 x 2 3) 2)

(define map1
  (lambda (f l)
    (if (null? l)
        '()
        (cons (f (car l))
              (map1 f (cdr l))))))

(map1 (lambda (y) (+ y 10)) '(4 5 1 3))

(define build-listx
  (lambda (n f)
    (let build-next ((i 0))
      (if (= i n)
      '()
      (cons (f i) (build-next (+ i 1)))))))

(build-listx 10 +)


(define build-list-iter
  (lambda (n f)
    (let iter (( i ( - n 1))
               (accum '()))
      (if (< i 0)
         accum
          (iter (- i 1) (cons (f i) accum))))))

(build-list-iter 10 +)

(define reversex
  (lambda (l)
    (if (null? l)
        '()
        (append (reverse (cdr l))
                (list (car l))))))

(reversex '(4 5 1 6))

(define rev-append
  (lambda (l1 l2)
    (if (null? l1)
        l2
        (rev-append (cdr l1)
                    (cons (car l1) l2)))))

(define reverse1
  (lambda (l)
    (rev-append l '())))

(reverse1 '(1 2 3 4 5))

(define perrin
  (lambda (n)
    (cond ((= n 0) 3)
          ((= n 1) 0)
          ((= n 2) 2)
     (else
     (+ (perrin (- n 2)) (perrin (- n 3)))))))

(perrin 10)

(define depth-map
  (lambda (f l)
    (map (lambda (x)
           (if (list? x)
               (depth-map f x)
               (f x)))
         l)))

(depth-map - '(1 (2 () (3)) (((4)))))


(define list??
  (lambda (l)
    (or (null? l)
        (and (pair? l)
             (list? (cdr l))))))
        
(list?? '(1 5 3))
(list?? '())

(define list?*
  (lambda (l)
    (or (null? l)
        (pair? l))))

(list?* '(1 5))


(define forall
  (lambda (f l)
    (or (null? l)
        (and (f (car l))
             (forall f (cdr l))))))

(forall odd? '(2 4 6 8))

(define exists
  (lambda (f l)
    (and (not (null? l))
         (or (f (car l))
             (exists f (cdr l))))))

(exists even? '(1 4 5 6))


(define foldrr
  (lambda (f term l)
    (if (null? l)
        term
        (f (car l) (foldrr f term (cdr l))))))

(foldrr + 0 '())

(define foldl
  (lambda (f term l)
    (let iter ((l l)
               (accum term))
      (if (null? l)
          accum
          (iter (cdr l)
                (f (car l) accum))))))
(foldl * 1 '(5 4 6 1))

(define appen
  (lambda (l1 l2)
    (if (null? l1)
        l2
        (cons (car l1) (appen (cdr l1) l2)))))

(appen '(1 2 3) '(4 5 6))

(define s
  (cons 1 (cons 2 3)))
(cddr s)

(define x
  '((1 2 3) (4 5 6) (7 8 9)))

(cdr x)

(map + '(1 2 3) '(4 5 6))

(map cdr '((1 2 3) (4 5 6)))

(+ ((lambda (x) 2) 1) 2)
((and + (lambda (x y) 4)) 2 3)
((lambda () +))
((lambda (y) (y 10)) (lambda (x) 30))
(((lambda (x y) (lambda (x) 6)) 1 2) 3)

(((lambda () (lambda () 1))))


((((lambda (x)
     (lambda (y)
       (y (y x))))
   (lambda (y) y))
  (lambda (x) x))
 10)