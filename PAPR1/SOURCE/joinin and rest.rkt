(define comb
  (letrec ((fak (lambda (n) (if (<= n 1)
                                1
(* n (fak (- n 1)))))))
    (lambda (n k)
      (/ (fak n) (fak k) (fak (- n k))))))

(comb 5 2)

(define lists '((1 2 3) (4 5 6)))

(cdr lists)

;(linearize '((4) 5 (4 6) (1)) -> (4 5 4 6 1)

(define linearize
  (lambda (l)
    (cond ((null? l) '())
          ((list? (car l)) (append (linearize (car l)) (linearize (cdr l))))
          (else (cons (car l) (linearize (cdr l)))))))

(linearize '((4) 5 (4 6) (1)))

((lambda (y)
   (y y  '((4) 5 (4 6) (1))))
 (lambda (linearize l)
   (cond ((null? l) '())
          ((list? (car l)) (append (linearize linearize (car l)) (linearize linearize (cdr l))))
          (else (cons (car l) (linearize linearize (cdr l)))))))


(define atoms
  (lambda (l)
    (cond ((null? l) 0)
          ((list? (car l)) (+ (atoms (car l))
                              (atoms (cdr l))))
          (else (+ 1 (atoms (cdr l)))))))

(atoms '((4) 5 (4 6) (1)))


(define fib
  (lambda (n)
    (if (<= n 1)
        n
        (+ (fib (- n 1))
           (fib (- n 2))))))

(fib 5)

((lambda (y)
   (y y 5))
 (lambda (fib n)
   (if (<= n 1)
       n
       (+ (fib fib (- n 1))
          (fib fib (- n 2))))))
   
;((a) b (c d) (e))

(define atom?
  (lambda (atom l)
    (if (null? l) #f
          (or (if (list? (car l))
                  (atom? atom (car l))
                  (equal? atom (car l)))
              (atom? atom (cdr l))))))

(atom? 'c '((a) b (c d) (e)))                               
           
           
(define map1
  (lambda (f l)
    (if (null? l)
        '()
        (cons (f (car l))
              (map1 f (cdr l))))))

(map1 (lambda (x) (+ x 1)) '(1 2))


(define euclid
  (lambda (a b)
    (if (= b 0)
        a
        (euclid b (modulo a b)))))

(euclid 16 32)

(define it
  (lambda (n term f)
    (if (<= n 0)
        '()
        (cons term (it (- n 1) (f term) f)))))

(it 2 1 list)

(define it2
  (lambda (n term f)
    (let iter ((n n) (accum '()))
      (if (<= n 0)
          accum
          (iter (- n 1) (cons term (map f accum)))))))

(it2 2 1 list)


(define it3
  (lambda (n term f)
    (foldr (lambda (x y)
             (cons term (map f y)))
           '()
           (build-list n identity))))

(it3 2 1 list)




                      
                   
    
       