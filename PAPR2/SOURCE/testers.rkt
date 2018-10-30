(define proc
  (let ((stav 100))
    (lambda (x y)
      (let ((out 0))
        (if (> stav 0)
            (begin
              (set! out (* x y))
              (set! stav (- stav out))
              out)
            0)))))

;(proc 2 3)
;(proc 20 30)
;(proc 2 3)

(define expt
  (lambda (x y)
    (if (= y 0)
        1
        (* x (expt x (- y 1))))))


(define tester
 (let ((counter 0))
   (lambda (proc x y)
     (let ((out 0))
       (if (>= counter 0)
           (begin
             (set! out (proc x y))
             (set! counter (+ counter y))
             (display counter)
             (newline)
             (display out)
             (newline)))))))

(tester expt 2 3)
(tester expt 10 20)

(display " \nNEW\n")

(define test
  (let ((count 0))
    (lambda (proc . args)
      (fluid-let ((* (let ((* *))
                       (lambda args
                         (set! count (+ count 1))
                         (apply * args)))))
     (let ((vysledek (apply proc args)))
      (display count)
       (newline)
      vysledek)))))

;(test expt 2 3)
;(test expt 10 20)

(define make-test
 (lambda ()
    (let* ((count 0)
           (test (lambda (proc . args)
      (fluid-let ((* (let ((* *))
                       (lambda args
                         (set! count (+ count 1))
                         (apply * args)))))
     apply proc args))))
    (stav (lambda () count))
    (nuluj (lambda () (set! count 0))))
  (lambda (signal . args)
    (cond ((equal? signal 'testuj)
           (apply test args))
          ((equal? signal 'vynuluj)
           (nuluj))
          ((equal? signal 'vypis)
           (stav))
          (else (error "neznama zprava."))))))

;(depth-map * '(1 2 3))

(define depth-map
  (lambda (f l)
    (map (lambda (x)
           (if (list? x)
               (depth-map f x)
               (f x)))
         l)))

(depth-map (lambda (x) (* x 2)) '(1 (2) 3))
