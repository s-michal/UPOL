
(define-macro new-if
  (lambda (test expr . alt)
    `'(if ,test ,expr
         (begin #f ,@alt))))

(define-macro while
  (lambda (condition . body)
    `(let loop ()
       (cond (,condition
              (begin . ,body))
             (loop)))))

(define counter 15)

(begin
  (while (> counter 10)
       (display counter)
       (newline)
       (set! counter (- counter 1)))
  (when (= counter 10)
    (display "DONE")))


(define-macro and2
  (lambda (expr1 expr2)
    `'(if ,expr1
         (if ,expr2
             #t
             #f)
         #f)))

;(and2 #f blahblah)

(define-macro or2
  (lambda (expr1 expr2)
    `(if ,expr1
          (display ,expr1)
          (if ,expr2
              (display ,expr2)
              #f))))
          
;(or2 (< 10 5) (null? '(4 5 60)))

(define-macro if*
  (lambda (expr1 expr2 . expr3)
    `(let (($result ,expr1))
       (if $result ,expr2 ,@expr3))))

(define-macro or*
  (lambda args
    (if (null? args)
        #f
        (if (null? (cdr args))
            (car args)
            `(if ,(car args)
                 ,(car args)
                 (or ,@(cdr args)))))))

;(if* (member 'b '(a b c d))
     ;(list 'nalezen $result)
     ;'blah)

;jako if, ale více podmínek, jednotlivé resulty jsou výsledky
;vyhodnocení předchozích
;(fluid-end)
;(fluid-end 1 (= $result 1) 3 $result)


;(or* 10 20 )

(define-macro fluid-end
  (lambda rest
    (if (null? rest)
        #t
    `(let (($result ,(car rest)))
       (cond ((equal? $result #f) #f)
             (,(null? (cdr rest)) $result)
             (else (fluid-end ,@(cdr rest))))))))
       

(fluid-end 1 (= $result 1) 3 $result)

;(for-each i '(1 0 -5) (set! i (+ i 10)) (display i) (newline))


(define-macro for-each
  (lambda (index list . body)
    (let ((sym-loop (gensym))
          (sym-list (gensym))
          (sym-index (gensym)))
      `(let ,sym-loop ((,sym-list ,list)
                        (,sym-index (if #f #f)))
          (if (null? ,sym-list)
              ,sym-index
                (,sym-loop (cdr ,sym-list)
                           (let ((,index (car ,sym-list)))
                            (begin ,@body))))))))

(for-each i '(1 0 -5) (set! i (+ i 10)) (display i) (newline))


;(multifor ((symbol 10 30 20)) (display symbol) (display " "))
;(multifor ((i 1 10) (j 2 5) (k 10 13)) (display (+ i j k)) (display " "))
                      
           




