(define mlist
  (lambda args
    (if (null? args)
        '()
        (mcons (car args) (apply mlist (cdr args))))))

(define cycle!
  (lambda (l)
    (let iter ((aux l))
      (if (null? (mcdr aux))
          (set-mcdr! aux l)
          (iter (mcdr aux))))))

(define s (apply mlist'(a b c d e)))
s
(cycle! s)
s

(define cyclic?
  (lambda (l)
    (let test ((rest (if (null? l)
                         '()
                         (mcdr l))))
      (cond ((null? rest) #f)
            ((eq? rest l)#t)
            (else (test (mcdr rest)))))))

(cyclic? s)

(define par (mcons 5 6))
par
(set-mcar! par 10)
par

(define clength
  (lambda (l)
    (if (null? l)
        0
        (let iter ((aux l)
                   (len l))
          (if (eq? (mcdr aux) l)
              len
              (iter (mcdr aux (+ 1 len))))))))

(define clist-ref
  (lambda (l i)
    (let iter ((aux l)
               (i i))
      (if (= i 0)
          (mcar aux)
          (iter (mcdr aux) (- i 1))))))
  

(define a (apply mlist '(1 2 3)))
a
(set-mcdr! (mcdr (mcdr a)) a)
a
(set-mcar! (mcdr a) a)
a

(assoc '(2) '((1 . a) ((2) . b)))



(define make-box
  (lambda (value)
    (lambda (signal . new-value)
      (cond ((equal? signal 'get) value)
            ((equal? signal 'set)
             (set! value (car new-value)))
             (else "neznamy signal" )))))

(define val (make-box 10))
(val 'get)
(val 'set 100)
(val 'get)

(define s (vector 10 20 30))
(vector-length s)
(define v (make-vector 10))
(vector-fill! v 'blah)
v

