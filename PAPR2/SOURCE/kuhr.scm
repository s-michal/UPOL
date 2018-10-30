(define data '())

(define make-list
  (lambda ()
    data))

(define is-empty? 
  (lambda ()
    (null? data)))

(define insert! 
  (lambda (item index)
    (if (= index 0)
        (set! data (cons item data))
        (let iter ((pos data)
                   (i index))
          (if (null? pos)
               (error "index out of range" ))
          (if (> i 1)
              (iter (cdr pos) (- i 1))
              (set-cdr! pos (cons item (cdr pos))))))))

(define delete! 
  (lambda (index)
    (if (= index 0)
        (begin
        (set-car! data (cadr data))
        (set-cdr! data (cddr data)))
        (let iter ((i index))
          (if (= i 1)
              (set-cdr! data (cddr data))
              (iter (- i 1)))))))


(display data)
(insert! 5 0)
(newline)
(display data)
(newline)
(insert! 10 1)
(display data)
(insert! 15 2)
(newline)
(display data)
(newline)
(insert! 11 3)
(display data)
(newline)
(delete! 1)
(display data)


(define seznam '(cons '() '()))

(define memorize! 
  (lambda (key elem)
    (let ((asoc (cons (cons key elem)  seznam)))
    	(set! seznam asoc))))

(define memorizee!
  (lambda (key elem)
    (let ((new (cons key elem)))
      (if (null? seznam)
          (begin
          (set-car! seznam new)
          (set-cdr! seznam '(1 2 3)))
          (begin
            (set-cdr! seznam (car seznam))
            (set-car! seznam new)
            seznam)))))


 
(memorizee! 'x 5)
(newline)
(display seznam)
(memorizee! 'y 10)
(newline)
(display seznam)
(newline)
(memorizee! 'z 15)
(newline)
(display seznam) 


(define lest '())

(define delete!
  (lambda (key)
   (if (equal? key (caar seznam))
       (begin
         (set-car! seznam (cadr seznam))
         (set-cdr! seznam (cddr seznam))
         list)
       (let iter ((l seznam))
        (set! lest l)
         (if (equal? key (caadr l))
             (begin
               (set-cdr! l (cddr l))
               seznam)
             (iter (cdr l)))))))
          
       
(delete! 'y)               
(newline)
(display seznam)
(newline)
;(display (eq? lest seznam))

