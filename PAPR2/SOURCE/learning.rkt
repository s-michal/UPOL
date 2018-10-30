(require rnrs/mutable-pairs-6)

(define proc
    (lambda (x y)
      (let ((out 0)
            (stav 0))
      (if (>= stav 0)
          (begin
            (set! stav (+ stav 1))
            (set! out (* x y))
           (display "counter is ")
           (display stav)
           (newline)
           (display "result is: ")
           (display out)
           (newline))
          0))))

;(proc 5 4)
;(proc 4 6)
;(proc 1 2)

;(for-each
 ; (lambda (x)
  ;  (display "cislo: ")
   ; (display x)
    ;(newline))
  ;'(1 2 3 4))

;(let ((i 0))
 ; (for-each
  ; (lambda (x)
   ;  (display (list i x))
    ; (newline)
     ;(set! i (+ i 1)))
     ;'(a b c d e f)))
(define value 10)

(define inc
  (lambda (x)
     (set! value (+ value x))
      value))

(fluid-let ((value 20))
  (display (inc 10))
  (newline)
  (display (inc 10))
  (newline))


(define make-inc
  (lambda ()
    (let ((value 0))
      (lambda (x)
        (set! value (+ value x))
        value))))

(define map-index
  (lambda (f l)
    (let ((i -1))
      (map (lambda (x)
             (set! i (+ i 1))
             (f i x))
           l))))

;(map-index list '(1 2 3 4))


(define map-back
  (lambda (f l)
    (let iter ((l l)
               (accum '()))
      (if (null? l)
          accum
          (iter (cdr l) (cons (f (car l)) accum))))))

;(map-back (lambda (x) (+ x 10)) '(1 2 3 4 5))

(define lengthh
  (let ((delka 0))
    (lambda (list)
      (set! delka 0)
      (for-each (lambda (x) (set! delka (+ delka 1)))
                 list)
      delka)))

(define make-pred
  (lambda (pred?)
    (let ((called-with-values '()))
      `(,(lambda (x y)
           (set! called-with-values
                 (cons (cons y x) called-with-values))
           (pred? x y)
        )))))


(define procs
  (let ((values '()))
    (lambda (signal . args)
      (cond ((eqv? signal 'remember)
             (begin
             (set! values (cons args values))
             values))
            ((eqv? signal 'forget)
             (begin
             (set! values '())
             values))))))

;(procs 'remember 10)
;(procs 'remember 20)
;(procs 'remember 30)
;(procs 'forget)
;(procs 'remember 10)

(define choose
  (let ((value '()))
  (lambda (signal . elem)
      (define remember
        (lambda (elem)
          (set! value (cons elem value))
          value))
      (define forget
        (lambda ()
          (set! value '())
          value))
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

;(remember 5)
;(remember 10)
;(remember 25)
;(forget)


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

(remember 10)
(remember 20)
(remember 30)
(forget)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define mlist
  (lambda args
    (if (null? args)
        '()
        (mcons (car args) (apply mlist (cdr args))))))

(define build-mlist
  (lambda (n f)
    (let iter ((i 0)
               (n n))
    (if (= n 0)
        '()
        (mcons (f i) (iter (+ i 1)(- n 1)))))))

(define mreverse
  (lambda (l)
    (let iter ((accum '())
               (l (if (mpair? l)
                      l
                      (apply mlist l))))
      (if (null? l)
          accum
          (iter (mcons (mcar l) accum) (mcdr l))))))


(define f-list
  (lambda (n)
    (if (= n 0)
        '()
        (mcons
         (build-mlist n (lambda (i) #f)) (f-list (- n 1))))))

;(define p (f-list 3))
;p
;(set-mcar! (mcar p) #t)
;p
;(set-mcar! (mcar (mreverse p)) #t)
;p

(define proc1
  (lambda (x)
    (let ((x x))
    (display (mlist "Input parametre: " x))
    (newline)
    (set-mcar! x (+ (mcar x) 1))
    x)))

(define test (lambda () (proc1 (apply mlist '(0)))))
(test)
(test)


(define a (mcons 10 '()))
(set-mcar! a a)
a