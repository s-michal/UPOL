(display 'REPLACE_X)
(display "\n")

;(proc 4 '(1 x 5 x)) -> (1 4 5 4)

(define proc
  (lambda (elem l)
    (foldr (lambda (y z)
             (if (equal? 'x y)
                 (cons elem z)
                 (cons y z) 
                 ))
           '()
           l)))

(proc 4 '(1 x 5 x))

(define proc-rek
  (lambda (elem l)
    (cond ((null? l) l)
          ((symbol? (car l)) (cons elem (proc-rek elem (cdr l))))
           (else  (cons (car l) (proc-rek elem (cdr l)))))))

(proc-rek 'c '(1 x 5 x x x 5 6 1 x))

;YY KOMB
((lambda (y)
   (y y 'c '(1 x 5 x 1 x)))
 (lambda (proc-rek elem l)
   (cond ((null? l) l)
          ((equal? 'x (car l)) (cons elem (proc-rek proc-rek elem (cdr l))))
           (else  (cons (car l) (proc-rek proc-rek elem (cdr l)))))))

(define proc-iter
 (lambda (elem l)
   (let iter ((accum '())
              (b (reverse l)))
     (cond ((null? b) accum)
           ((symbol? (car b))(iter (cons elem accum) (cdr b)))
           (else (iter (cons (car b) accum) (cdr b)))))))

(proc-iter 'HELLO '(x 1 x 2 x 3 x 4))


(define member?
  (lambda (elem l)
    (not (null? (filter
                 (lambda (x)
                   (equal? x elem))
                 l)))))

(display 'UNION)
(display "\n")

(define union
  (lambda (l1 l2)
    (foldr (lambda (x y)
             (if (member? x y)
                 y
                 (cons x y)))
            l2
            l1)))

(union '(1 2 3) '(3 4 5))

;(1 2 5 6) -> (1 2 4 5 6)

(display 'REVERSE)
(display "\n")

(define reves
  (lambda (l)
    (let iter ((accum '())
               (b l))
      (if (null? b)
          accum
      (iter (cons (car b) accum) (cdr b))))))

(reves '(1 2 3 4))


(display 'JOININ)
(display "\n")

(define joinin
  (lambda (n l)
    (cond ((null? l) (cons n (reverse l)))
          ((= n (car l)) (joinin n (cdr l)))
          ((<= n (car l)) (append (list n) (list (car l)) (cdr l)))
          ((>= n (car l)) (cons (car l) (joinin n (cdr l)))))))

(joinin 10 '())


(display "GROUPS")
(display "\n")

;groups '(a b c d e f g) 3) -> ((a b c) d e f g)


(define groupss
  (lambda (s n)
    (let iter ((accum '())
               (l s)
               (i n))
    (cond  ((> i 0) (iter (cons (car l) accum) (cdr l) (- i 1)))
           ((= i 0) (cons (reverse accum) l))))))
          

(groupss '(a b c d e f g) 4)

(define groups-rek
  (lambda (l x)
    (reverse (let name ((l (reverse l))
                        (accum (length l)))
               (cond ((= x 0) l)
                     ((equal? x accum) (list (reverse l)))
                     (else (cons (car l) (name (cdr l) (- accum 1)))))))))

(groups-rek '(a b c d e f g) 4)

(display "NOTANY")
(display "\n")

;(notany? even? '(1 2 3 4 5)) -> #f
;(notany? even? '(1 3 5 7 9)) -> #t


(define notany
  (lambda (pred l)
    (cond ((null? l) #t)
          ((pred (car l)) #f)
          (else (notany pred (cdr l))))))


(define notany-iters
  (lambda (pred l)
      (or (null? l)
          (and(not (pred (car l)))
              (notany-iters pred (cdr l))))))

     
(notany even? '(1 2 3 8 5))
(notany-iters even? '(2 3 1))

(display "COUNTIF")
 (display "\n")  

;(count-if symbol? '(1 a 2 b c)) -> 3

(define count-if
  (lambda (pred l)
    (let iter ((n 0)
               (l l))
      (cond ((null? l) n)
            ((pred (car l)) (iter (+ 1 n) (cdr l)))
            (else (iter n (cdr l)))))))
  
(count-if symbol? '(1 a 2 b c))
(count-if symbol? '(1 a 2))
(count-if symbol? '())

(display "INTERLEAVE")
(display "\n")

;interleave '(1 2) '(a) - > '(1 a 2)

(define interleave
  (lambda (l1 l2)
    (cond ((null? l2) l1)
          ((null? l1) l2)
          (else (append (list (car l1)) (list (car l2))
                (interleave (cdr l1) (cdr l2)))))))

(define interleaves
  (lambda (l1 l2)
    (cond ((null? l2) l1)
          ((null? l1) l2)
          (else (cons (car l1) (cons (car l2)
                (interleave (cdr l1) (cdr l2))))))))
          
(interleave '(1 2) '(a b c))
(interleaves '(1 2) '(a b))

(display "ATLEAST?")
(display "\n")

(define atleast?
  (lambda (elem n l)
      (cond ((= n 0) #t)
            ((null? l) #f)
      (else (if (equal? (car l) elem)
            (atleast? elem (- n 1) (cdr l))
            (atleast? elem n (cdr l)))))))
          
            

(atleast? 'a 2 '(a b c a d))
(atleast? 'a 7 '(a b c a d a a a a))


;(mlist '(10 20 30)) ->(6000 600 30)

(define mlist
  (lambda (l)
    (if (null? l)
        '()
        (cons (apply * l)
              (mlist (cdr l))))))

(display "MLIST")
(display "\n")

(mlist '(10 20 30))

(define mlis
  (lambda (l)
    (cond ((null? l) l)
        (else (cons (* (car l) (eval `(* ,@(cdr l))))   
             (mlis (cdr l)))))))
            
  
(mlis '(10 20 30))
