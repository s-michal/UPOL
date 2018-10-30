(define mlist
  (lambda args
    (if (null? args)
        '()
        (mcons (car args) (apply mlist (cdr args))))))
  

(define f-list
  (lambda (n)
    (build-list n
                (lambda (i)
                  (build-list (- n i)
                              (lambda (x) #f))))))

(define s (apply mlist (f-list 4)))
s


(define list-set!
  (lambda (l index value)
    (let iter ((l (apply mlist l))
               (i index))
      (if (= i 0)
          (set-mcar! l value)
          (iter (mcdr l) (- i 1)))
      l)))

(list-set! '(5 5 5 5 5) 4 0)



(define x '(1 2 3))
(define y '(4 5 6))

(define append!
  (lambda (l1 l2)
    (if (null? l1)
      l2
      (let iter ((l (apply mlist l1)))
        (if (null? (mcdr l))
             (begin
               (set-mcdr! l l2)
               l1)
             (iter (mcdr l)))))))

(append! x y)

(define list-insert! s)

(define s '(a b c))



;(define list-delete!
;  (lambda (l index)
;    (if (= index 0)
;        (begin
;          (set-mcar! s (cadr s))
;          (set-cdr! s (cddr s)))
;        (let iter ((l l)
;                   (index index))
;          (if (= index 0)
;              (set-mcdr! l (mcddr l))
;              (iter (mcdr l) (- index 1)))))))
;


;(define make-queue
;  (lambda ()
;    (cons '() '())))
;
;(define empty-queue?
;  (lambda (queue)
;    (and (null? (car queue))
;         (null? (cdr queue)))))
;
;(define queue-get caar)
;
;(define queue-insert!
;  (lambda (queue elem)
;    (if (empty-queue? queue)
;        (begin
;          (set-mcar! queue (mcons elem (mcar queue)))
;          (set-mcdr! queue (mcar queue)))
;        (begin
;          (set-mcdr (mcdr queue) (mlist elem))
;          (set-cdr! queue (cddr queue))))))
;
;(define q (make-queue))
;
;(queue-insert! q  1)
;(queue-insert! q  10)
;(queue-insert! q  120)
;;(list-delete! s 1)

