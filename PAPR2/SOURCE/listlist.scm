(define megasum (lambda (list)
    (cond ((null? list) 0)
          ((list? (car list)) (+ (megasum (car list)) (megasum (cdr list))))
          (t (+ (car list) (megasum (cdr list))))
          )))

;(display (megasum '((8) 5 (2 () (9 1) 3)))) 


(define max (lambda (list)
    (let iter ((accum (car list))
               (l (cdr list)))
      (cond 
        ((null? l) accum)
            ((> (car l) accum)
             (begin
               (set! accum (car l)) 
               (iter accum (cdr l)))) 
            (t (iter accum (cdr l))))
      )))

(display (max '(0 5 4)))

