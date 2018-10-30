(define x 5)
(define y #t)

(define-macro swap
  (lambda (sym1 sym2)
    `(let ((temp 0))
       (begin
         (set! temp ,sym1)
         (set! x ,sym2)
         (set! y temp)))))

(swap x y)


(define-macro WHEN
  (lambda (condition . body)
    (if (null? body)
        (error "body missing")
       `(if ,condition
            (begin ,@body)))))
;(WHEN #t)

(define-macro UNLESS
  (lambda (condition . body)
    (if (null? body)
        (error "body missing")
        `(WHEN (not ,condition)
             (begin ,@body)))))

;(let ((x 1))
 ; (UNLESS (> x 1)
  ;  (set! x 2)
   ; x))

(define-macro if-let
  (lambda (condition then else)
    (let ((x (car condition)))
    `(if (let ((x ,@(cdr condition)))
           (if ,x
               ,then))
          ,else))))

;(if-let (x (assoc 1 '()))
 ; (+ 1 x)
  ;0)

(define mlist
  (lambda (list)
    (if (null? list)
        '()
        (mcons (car list) (mlist (cdr list))))))


(define remove-if!
  (lambda (pred l)
    (let ((rest (mcdr l)))
      (unless (null? rest) 
	    (if (pred (mcar rest))
		(set-mcdr! l (mcdr rest))
		(set! l (mcdr l)))
	    (remove-if! pred l)))))

(define s (mlist '(1 2 a b)))
(remove-if! number? s)


(define-macro with-unique-names
  (lambda (list body)
    (if (null? list)
        body
        `(let ((,(car list) (gensym))
               (,@(cdr list) (gensym)))
               ,body))))

              
(with-unique-names (a b)
  `(lambda (,a ,b)
     (* ,a ,b)))

(define-macro with-unique-names2
  (lambda (list body)
    (if (null? list)
        body
        `(let ((,(car list) (gensym)))
                 (with-unique-names2 ,(cdr list) ,body)))))



(with-unique-names2 (a b)
  `(lambda (,a ,b)
     (* ,a ,b)))



        
                     



    