(define-macro delay
  (lambda exprs
    `(let ((result (lambda () (begin ,@exprs)))
           (evaluated? #f))
       (lambda ()
         (begin
           (if (not evaluated?)
               (begin
                 (set! evaluated? #t)
                 (set! result (result)))
               result))))))

(define force
  (lambda (promise)
    (promise)))


(define-macro cons-stream
  (lambda (a b)
    `(cons ,a (delay ,b))))

(define stream?
  (lambda (elem)
    (or (null? elem)
        (and (pair? elem)
             (promise? (cdr elem))
             (stream? (force (cdr elem)))))))

(define stream-car car)

(define stream-cdr
  (lambda (list)
    (force (cdr list))))

(define display-stream
  (lambda (s . n)
    (if (and (not (null? s)) (or (null? n) (> (car n) 0)))
        (begin
          (display (stream-car s))
          (if (or (null? n) (> (car n) 1))
              (begin
                (display ", ")
                (if (null? n)
                    (display-stream (stream-cdr s))
                    (display-stream (stream-cdr s) (- (car n) 1)))))))))



(define test2
  (stream-cons (+ 1 2)
               (stream-cons (begin (display "a") (+ 3 4))
                                   (stream-cons (begin (display "b") (+ 5 6)) ()))))

;(display-stream test2 1)(newline)
;(display-stream test2 2)(newline)

(define test
  (stream-cons (+ 1 2)
               (stream-cons (begin (display "ted")
                                   (+ 3 4)) ())))

(define list->stream
  (lambda (list)
    (foldr (lambda (x y)
             (stream-cons x y))
           () list)))

(define stream
  (lambda args
    (list->stream args)))

(define naturals-proc
  (lambda (i)
    (stream-cons i (naturals-proc (+ i 1)))))

(define plus (naturals-proc 0))

(define build-stream
  (lambda (f)
    (let proc ((i 0))
      (stream-cons (f i)
                   (proc (+ i 1))))))

(define naturals (build-stream (lambda (i) (+ i 1))))

(define make-arit-stream
  (lambda (elem dif)
    (let iter ((prvek elem))
      (stream-cons prvek (iter (+ prvek dif))))))

(define my-stream
  (make-arit-stream 10 2))

(define stream-map
  (lambda (procs . args)
    (if (stream-null? (car streams))
        '()
        (cons-stream
         (apply (stream-car procs) (map stream-car args))
         (apply stream-map (stream-cdr f) (map stream-cdr args))))))

(define pow-gen
  (lambda (n)
    (cons-stream (lambda (x) (expt x n))
                 (pow-gen (+ 1 n)))))

(define powers (pow-gen 0))



                    







