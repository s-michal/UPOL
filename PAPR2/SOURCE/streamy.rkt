(require racket/stream)

(define-macro delay
  (lambda exprs
    `(let ((result (lambda () (begin ,@exprs)))
           (evaluated? #f))
       (lambda ()
         (begin
           (if (not evaluated?)
               (begin
                 (set! evaluated? #t)
                 (set! result (result))))
               result)))))

(define-macro cons-stream
  (lambda (a b)
    `(cons ,a (delay ,b))))

(define force
  (lambda (promise)
    (promise)))


(define scream (cons-stream 10 (+ 10 20)))

(define stream??
  (lambda (elem)
    (or (null? elem)
        (and (pair? elem)
             (and (promise? (cdr elem))
                 (stream? (force (cdr elem))))))))

(define stream
  (lambda args
    (list->stream args)))

(define list->stream
  (lambda (list)
    (foldr
     (lambda (x y) (cons-stream x y))
     `()
     list)))

(define s (stream-cons 10 20))


(define eratosthenes
  (lambda (num)
        (let iter ((number num))
          (if (or (= number 0) (= number 1))
              '(5 2)
          (if (not (or (= (modulo number 2) 0) (= (modulo number 5) 0)))
              (begin
                (cons number (iter (- number 1))))
              (iter (- number 1)))))))

(reverse (eratosthenes 50))

    