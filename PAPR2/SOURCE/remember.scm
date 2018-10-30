
(display "COMPOSE")
(newline)

(define compose
  (lambda f
    (lambda (n)
    	(let iter ((f f)
                   (n n))
      (if (null? f)
          n
          (iter (cdr f) ((car f) n)))))))
     
(display ((compose - - - ) 1))
(newline)
(display "COUNTER")

(define counter
 (let ((count -1))
   (lambda (n)
      (lambda ()
        (set! count (+ count 1))
        count))))
         	

(newline)
(display
(let ((c (counter 0)))
  (list (c) (c) (c))))

(newline)
(display 
  (assoc 'd '((a 10) (c 5) (d 10))))

(newline)


(define insert! 
  (lambda (list index elem)
    (if (= index 0)
        (begin
          (set-cdr! list (cons (car list) (cdr list)))
          (set-car! list elem)
          list)
        (let iter ((l list)
                   (i index))
          (if (= i 1)
              (begin 
                (set-cdr! l (cons elem (cdr l)))
                l)
              (iter (cdr l) (- i 1)))))))

(display (insert! '(1 2 3 4) 2 5555))

(define delete!
  (lambda (list index)
   (if (= index 0)
       (begin
         (set-car! list (cadr list))
         (set-cdr! list (cddr list))
         list)
       (let iter ((l list)
                  (i index))
         (if (= i 1)
             (begin
               (set-cdr! l (cddr l))
               l)
               (iter (cdr l) (- i 1)))))))

(newline)
(display (delete! '(1 2 3 4) 1))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;QUEUE
;vytvoř prázdnou frontu
(define make-queue
  (lambda ()
    (cons '() '())))

;test, jestli je prázdná

(define empty-queue? 
  (lambda (queue)
    (and (null? (car queue))
         (null? (cdr queue)))))

;vrať prvek z vrcholu fronty
(define queue-get caar)

(define queue-insert! 
  (lambda (queue elem)
    (if (empty-queue? queue)
        (begin
          (set-car! queue (cons elem (car queue)))
          (set-cdr! queue (car queue))
          queue)
        (begin
          (set-cdr! (cdr queue) (list elem))
          (set-cdr! queue (cddr queue))
          queue))))

(newline)
(define queue (cons '() '()))
(display
  (begin
          (set-car! queue (cons 5 (car queue)))
          (set-cdr! queue (car queue))
          queue))
(newline)
(display
  (begin
          (set-cdr! (cdr queue) (list 4))
          (set-cdr! queue (cddr queue))
          queue))


(define queue-delete! 
  (lambda (queue)
    (if (not (empty-queue? queue))
        (begin
          (set-car! queue (cadr queue))
          (if (null? (car queue))
              (set-cdr! queue '()))
          queue))))

(define cycle! 
  (lambda (list)
    (let iter ((l list))
      (if (null? (cdr l))
          (begin
          (set-cdr! l list)
          l)
          (iter (cdr l))))))

(define cyclic? 
  (lambda (l)
    (let test ((rest (if (null? l)
                         '()
                         (cdr l))))
      (cond ((null? rest) #f)
            ((eq? rest l) #t)
            (else (test (cdr rest)))))))

(newline)
(define s '(1 2 3))
(cycle! s)
(display (cyclic? s))

(define uncycle! 
  (lambda (l)
    (let iter ((aux l))
      (if (eq? (cdr aux) l)
          (set-cdr! aux '())
          (iter (cdr aux))))))

(define clength 
  (lambda (l)
    (if (null? l) 
        0
        (let iter ((aux l)
                   (len 1))
          (if (eqv? (cdr aux) l)
              len
              (iter (cdr aux) (+ len 1)))))))

(newline)
(display (clength s))

(define clist-ref
  (lambda (l index)
    (let iter ((aux l)
               (i index))
      (if (= i 0)
          (car aux)
          (iter (cdr aux) (- i 1))))))

(newline)
(display (clist-ref s 10))

(define swap
  (lambda (a b)
    (let ((a a)
          (b b)
          (tmp 0))
      (begin
        (set! tmp a)
        (set! a b)
        (set! b tmp)
        (list a b)))))

(define vymena (swap 10 20))
(newline)
(display vymena)