(define linearize
  (lambda (l)
    (cond ((null? l) '())
          ((list? (car l)) (append (linearize (car l))
                                   (linearize (cdr l))))
          (else (cons (car l) (linearize (cdr l)))))))

(linearize '(1 (4) ((6))))

(define atoms
  (lambda (l)
    (cond ((null? l) 0)
          ((list? (car l)) (+ (atoms (car l))
                              (atoms (cdr l))))
          (else (+ 1 (atoms (cdr l)))))))

(atoms '(1 () 2 (a (() (b (c))) (d) e)))

(define depth-accum
  (lambda (combine nil modifier l)
    (cond ((null? l) nil)
          ((list? (car l)) (combine (depth-accum combine nil modifier (car l))
                                    (depth-accum combine nil modifier (cdr l))))
          (else (combine (modifier (car l))
                (depth-accum combine nil modifier (cdr l)))))))

(define depth-count
  (lambda (atom l)
    (depth-accum + 0 (lambda (x)
                       (if (equal? atom x)
                           1
                           0))
                 l)))

(depth-count 'a '(1 () 2 (a (() (b (a))) (d) e)))

(define depth-find
  (lambda (x l)
    (depth-accum (lambda (x y) (or x y))
                 #f
                 (lambda (y) (equal? x y))
                 l)))

(depth-find 'a '(1 () 2 (a (() (b (a))) (d) e)))

((lambda ()
   (lambda (x) 10)))

((lambda (x) #t)
 ((lambda (y)
    (lambda (x)
      (lambda (y) #f)))1))
         
((lambda (x) #t)
 ((lambda (y)
    (lambda (x) #f))1))

(equal? 4 #t)

(letrec ((x y)
         (y 10))
  (list x y))


