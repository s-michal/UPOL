(define-syntax set-car!
  (syntax-rules ()
    ((_ l new_car) (set! l (cons new_car (cdr l))))))

(define-syntax set-cdr!
  (syntax-rules ()
    ((_ l new_cdr) (set! l (cons (car l) new_cdr)))))

(define mlist
  (lambda args
    (if (null? args)
        '()
        (mcons (car args) (apply mlist (cdr args))))))

;-------------------------------------------------------------------
;REVERSE
(define swap-mpair
  (lambda (p)
    (let ((first (mcar p)))
      (set-mcar! p (mcdr p))
      (set-mcdr! p first))))

(define depth-reverse!
  (lambda (list)
    (let ((processed '()))
      (let iter ((l list))
        (if (mpair? l)
        (when (not (memq l processed))
              (set! processed (cons l processed))
              (swap-mpair l)
              (iter (mcar l))
              (iter (mcdr l))))))))


(define t (mcons (mcons 1 2) (mcons 'a 'b)))
;t
(depth-reverse! t)

;DLIST
(define cons-dlist
  (lambda (elem dlist)
    (let ((new-cell (mcons elem (mcons '() dlist))))
      (if (not (null? dlist))
          (set-mcar! (mcdr dlist) new-cell))
      new-cell)))


(define create-dlist
  (lambda args
    (if (null? args)
        '()
        (cons-dlist (car args)
                    (apply create-dlist (cdr args))))))

(define p (create-dlist 4 3 2 0 1))
p

(define insert!
  (lambda (elem index list)
    (let ((new (mcons elem
                      (mcons '()'())))
          (list p))
      (if (= index 0)
          (begin
            (set-mcar! (mcdr new) 5) 
            (set-mcdr! (mcdr new) 10)
            list)
          (insert! elem (- index 1) (mcdr list))))))


(insert! 3 1 p)

    