;(define set
;  (let ((last 0))
;    (lambda arg
;      (if (null? arg)
;          last
;          (begin
;            (set! last (car arg))
;            last)))))
;
;(define add
;  (let ((rem (void)))
;    (lambda (arg)
;      (begin
;        (set! rem (set))
;        (set! rem (+ rem arg))
;        rem))))
;
;(set 10)
;(set 50)
;(add 10)
;(set 60)
;(add 15)

(define aux
  (lambda ()
    (let ((value (void)))
      `(,(lambda (arg)
           (set! value arg)
           value)
        ,(lambda arg
           (if (null? arg)
               value
               (begin
                 (set! value (+ (car arg) value))
                 value)))))))

(define set #f)
(define add #f)
(let ((t (aux)))
  (set! set (car t))
  (set! add (cadr t)))

(set 10)
(set 50)
(add 15)
      



(define a 20)
(define b 10)

(define-macro swap
  (lambda (a b)
    (let ((temp (gensym)))
    `(let ((,temp (void)))
       (set! ,temp ,'a)
       (set! ,'a ,'b)
       (set! ,'b ,temp)))))

(swap a b)
a
b

(define object
  (let ((value 0))
    (lambda (signal . args)
      (cond ((equal? signal 'add) (set! value (+ (car args) value)) value)
            ((equal? signal 'multi) (set! value (* (car args) value)) value)
            (else (error "WRONG SIGNAL"))))))

(object 'add 10)
(object 'multi 5)


(define-syntax foreach
  (syntax-rules (in do)
    ((foreach var in list do stmt ...)
     (let loop ((l list))
       (if (not (null? l))
           (let ((var (car l)))
             stmt ...
             (loop (cdr l))))))))

(foreach i in '(1 3 7 8)
         do (display i)
         (newline))

(newline)
(define-syntax for
  (syntax-rules (from to do)
    ((for from var1 to var2 do stmt ...)
     (let loop ((var var1))
       (if (not (= var var2))
           (begin stmt ...
                  (loop (+ var 1))))))))

(let ((j 0))
  (for from 0 to 10 do
    (set! j (+ j 10))
    (display j)
    (newline)))

(define-syntax OR
  (syntax-rules ()
    ((OR) #f)
    ((OR test) (if test test #f))
    ((OR test1 test2 ...)
     (let ((result test1))
      (if result result (OR test2 ...))))))


(define lengthh
  (lambda (l)
    (call/cc
     (lambda (f)
       (let iter ((l l)
                  (n 0))
         (if (null? l)
             n
             (if (= n 5)
                 (f n)
                 (iter (cdr l) (+ n 1)))))))))

(lengthh '(1 2 3 4 5 6 7 8 9 10 20))


