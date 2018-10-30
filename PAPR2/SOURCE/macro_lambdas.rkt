(define-macro while
  (lambda (condition . body)
    `(let loop ()
       (if ,condition
           (begin ,@body)
           (loop)))))


(define counter 10)

;(while (> counter 5)
 ;      (set! counter (- counter 1))
      ; (display counter))


(define-macro and2
  (lambda (test1 test2)
    `(if, test1
         (if ,test2
             ,test2
             #f)
         #f)))

;(and2 #f 2)

(define-macro andd
  (lambda args
    (if (null? (cdr args))
        (car args)
        `(if ,(car args)
             (andd ,@(cdr args))
             #f))))

;(andd 1 2 5)

(define-macro OR
  (lambda (test1 test2)
    `(if ,test1
         ,test1
         (if ,test2
             ,test2
             #f))))

;(OR #f 2)

(define-macro orr
  (lambda args
    (if (null? args)
        #f
        `(if ,(car args)
             ,(car args)
             (orr ,@(cdr args))))))

;(orr #f 2 3)

;(cond ((condition) action)
;      (else action))

;(if (condition)
;    (action)
;    (if (equal? (car last) "else")
;         (action)))

(define-macro condd
  (lambda (action1 action2)
    `(if ,(car action1)
         ,@(cdr action1)
         (if (equal? ,(car action2) 'else)
            ,@(cdr action2)
             #f))))

;(condd ((> 0 1) 10)
 ;      ('else 20))


;(((> 0 1) 10) ((equal? 50 10) 20) (else 30))


(define-macro COND
  (lambda args
    (if (null? args)
        #f
    (if (equal? (caar args) 'else)
        (cadar args)
        `(if ,(caar args)
             ,(cadar args)
             (COND ,@(cdr args)))))))

;(COND ((> 0 1) 10)
     ; ((equal? 50 10) 20))

(let ((x 10)(y 20))
 (+ x y))

;((lambda (x y)
 ;  (+ x y)) 10 20)

(define-macro lett
  (lambda (args . body)
    (if (null? args)
        body
        `((lambda (,(caar args) ,(caadr args))
            (begin ,@body))
          ,(cadar args) ,@(cdadr args)))))

;(lett ((x 10)(y 20))
 ;(+ x y))

(define-macro LET
  (lambda (args . body)
    `((lambda ,(map car args)
          (begin ,@body))
      ,@(map cadr args))))
        
;(LET ((x 10)(y 20))
 ;(+ x y))

;((lambda (x)
; ((lambda (y)
;     (+ x y)) 20) 10)

(define-macro let**
  (lambda (args . body)
    (if (null? args)
        `((lambda () ,@body))
        `((lambda ,(list (caar args))
            (let** ,(cdr args) ,@body))
           ,(cadar args)))))

(let** ((x 10)
        (y 20))
       (+ x y))



