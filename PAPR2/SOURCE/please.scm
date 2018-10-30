(define proc1
  (lambda (x)
    (display (list "Input parametre: " x))
    (newline)
    (set-car! x (+ (car x) 1))
    x))

(define test (lambda () (proc1 '(0))))
(display (test))
(newline)
(display (test))
(newline)

;nedestruktivní verze

(define list-set
  (lambda (l index elem)
    (let aux ((l l)
              (i 0))
      (if (= i index)
          (cons elem (cdr l))
          (cons (car l) (aux (cdr l) (+ i 1)))))))

(display
  (list-set '(1 2 3 4 5) 2 5))

;destruktivní

(define list-set-d
  (lambda (l index elem)
    (let iter ((l l)
               (i 0))
      (if (= i index)
          (set-car! l elem)
          (iter (cdr l) (+ i 1))))
      l))

(newline)
(display
  (list-set-d '(1 2 3 4 5) 2 5))


(define append2
  (lambda (l1 l2)
    (if (null? l1)
        l2
        (let iter ((l l1))
          (if (null? (cdr l))
              (begin 
                (set-cdr! l l2)
                l1)
              (iter (cdr l)))))))

(newline)
(display (append2 '(1 2 3) '(4 5 6)))

(define x '(1 2 3))
(define y '(a b c))
(newline)
(display(append2 x y))
(newline)
(display x)

(define append!
  (lambda args
    (foldr append2 '() args)))



(define list-insert! 
  (lambda (l index value) 
    (if (= index 0)
        (begin
           (set-cdr! l (cons (car l) (cdr l))) 
           (set-car! l value) l) 
        (let iter ((l l) 
           		(index index)) 
         (if (= index 1)
             (set-cdr! l (cons value (cdr l)))
              (iter (cdr l) (- index 1)))
         l))))

(newline)
(display (list-insert! '(1 2 3 4 5) 3 5))

(define list-delete!
  (lambda (l index)
    (if (= index 0)
        (begin
          (set-car! l (cadr l))
          (set-cdr! l (cddr l))
          l)
        (let iter ((l l)
                   (i index))
          (if (= i 1)
              (set-cdr! l (cddr l))
              (iter (cdr l) (- i 1)))
          l))))

(newline)
(display (list-delete! '(1 2 3 4) 1))

(define make-stack
  (lambda ()
   (let ((values '()))
    
    (define push
      (lambda (elem)
        (car values)))
    
    (define add
      (lambda (elem)
          (set! values (cons elem values))
          values))
    
    (define delete
    	(lambda ()
         (set! values (cdr values))
         values))
    
  	(lambda (signal . elem)
    	(cond ((equal? signal 'push) (push elem))
           	  ((equal? signal 'add) (add elem))
              ((equal? signal 'delete) (delete))
              (else (error "ERROR")))))))


(newline)
(define stack (make-stack))
(display (stack 'add 10))
(newline)
(display (stack 'add 20))
(display (stack 'add 40))

(newline)


(define choose
  (let ((value '()))
    (define remember
        (lambda (elem)
          (set! value (cons elem value))
          value))
      (define forget
        (lambda ()
          (set! value '())
          value))
  (lambda (signal . elem)
        (cond ((equal? signal 'remember) (remember elem))
               ((equal? signal 'forget) (forget))
               (else (error "unknown signal"))))))

;(choose 'remember 5)
;(choose 'remember 15)
;(choose 'remember 55)
;(choose 'forget)
;(choose 'remember 10)

(define remember
  (lambda (elem)
    (choose 'remember elem)))

(define forget
  (lambda ()
    (choose 'forget)))

(display (remember 5))
(newline)
(display (remember 10))
(newline)
(display (remember 25))
(newline)
(display (forget))
(newline)
(display (remember 5))
(newline)


(define test
  (let ((count '()))
    (define (car test) 'remember)
    (define (cadr test) 'forget)
    `(,(lambda (elem)
         (set! count (cons elem count))
         count)
      ,(lambda ()
         (set! count '())
         count))))

;(display (remember 10))
;(newline)
;(display (remember 20))
;(remember 30)
;(forget)


(define chose
  (let ((value '()))
    (define remember
        (lambda args
          (set! value (list elem value))
          value))
      (define forget
        (lambda ()
          (set! value '())
          value))
  (lambda (signal . elem)
        (cond ((equal? signal 'remember) (remember elem))
               ((equal? signal 'forget) (forget))
               (else (error "unknown signal"))))))


(define rememberr
  (lambda (elem)
    (chose 'remember elem)))

(define forgett
  (lambda ()
    (chose 'forget)))


(remember 1 2 3)