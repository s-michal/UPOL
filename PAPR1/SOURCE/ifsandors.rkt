(define acons
  (lambda (key val alist)
    (cons (cons key val) alist)))

(define alist
  (lambda vals
    (if (null? vals)
        '()
        (acons (car vals)
               (cadr vals)
               (apply alist (cddr rest))))))


(define ornf
  (lambda values
    (if (null? values)
        #f
    (if (car values)
        (car values)
        (apply ornf (cdr values))))))

(ornf #f #f #f)

(define andfn
  (lambda values
    (if (null? values)
        values
    (if (car values)
        (apply andfn (cdr values))
        #f
        ))))

(andfn 5 4 5)








        
        
        