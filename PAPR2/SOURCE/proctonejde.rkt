(define-macro ifs
  (lambda (test expr . alt)
    `'(let ((result ,test))
       (if result
           ,expr
           ,@alt))))

;(ifs 10 result 50)

(define-macro fluid-end
  (lambda rest
    (if (null? rest)
        #t
    `(let (($result ,(car rest)))
       (cond ((equal? $result #f) #f)
             (,(null? (cdr rest)) $result)
             (else (fluid-end ,@(cdr rest))))))))



(define-macro help
  (lambda args
    (if (null? args)
        (void)
    `(let ((counter 0))
           (begin
             (set! counter ,(car args))
             (display counter)
             (newline)
             (help ,@(cdr args)))))))


;(help 5 10 20)

(define-macro blah
  (lambda args
    (if (null? args)
        #f
        `(let ((counter 0)
               (result ,(car args)))
           (begin
             (set! counter result)
             (display counter))))))

;(blah 1 4 3)

;CYKLY

;WHILE CYKLUS

(define-macro while
  (lambda (condition . body)
    `(let loop ()
       (if ,condition
          (begin ,@body)
           (loop)))))

(define counter 10)
;(while (> counter 0)
;       (set! counter (- counter 2))
;       (display counter)
;       (if (= counter 0)
;           (begin (newline)
;           (display "DONE"))))


;GENSYM STYLE
(define-macro WHILE
  (lambda (condition . body)
    (let ((let-loop (gensym)))
    `(let ,let-loop ()
       (if ,condition
          (begin ,@body)
           (,let-loop))))))

;FOR CYKLUS

(define-macro for
  (lambda (start condition growth . body)
    (if (null? body)
        (void)
        `(let loop ((i ,start)
                    (counter 0))
           (if ,condition
               (begin ,@body
                      (set! i (,growth i 1))
                      (newline)
                      (loop i counter)))))))

;(for 0 (< i 10) +
 ; (set! counter (+ 20 counter))
  ;(display counter))

;(for 9 (> i 0) -
;   (set! counter (+ 20 counter))
;   (display counter))

(define-macro FOR
  (lambda (init condition incr . body)
    (let ((loop-name (gensym)))
      `(begin
         ,init
         (let ,loop-name ()
           (if ,condition
               (begin ,@body
                      ,incr
                      (,loop-name))))))))


(define-macro DO
  (lambda (binding condition . body)
    (let ((loop-name (gensym)))
      `(let ,loop-name
         ,(map (lambda (x)
                 (list (car x) (cadr x)))
               binding)
         (if ,(car condition)
             (begin ,@(cdr condition)
                    (begin ,@body
                           (,loop-name ,@(map caddr binding)))))))))

(DO ((x '(1 3 5 7 9) (cdr x))
     (sum 0 (+ sum (car x))))
    ((null? x) sum)
    (display (list x sum))
    (newline))
     

(define-macro deff
  (lambda (first . args)
    (if (symbol? first)
        `(define ,first ,@args)
        `(define ,(car first)
          (lambda ,(cdr first)
            ,@args)))))

;(deff (proc x)
 ; (+ x 10))


;(case (+ 1 3)
;((0 1 2) 'blah)
;((3 4) 'ahoj)
;(else 'nic)

(define-macro case
  (lambda (value . clist)
    `'(let ((result ,value))
       (cond ,@(map (lambda (i)
                      (if (list? (car i))
                          `((member result ',(car i))
                            ,(cadr i))
                          `(else ,(cadr i))))
             clist)))))

;(case (+ 1 3)
;((0 1 2) 'blah)
;((3 4) 'ahoj)
;(else 'nic))

;HYGIENICKA MAKRA

(define-syntax def
  (syntax-rules ()
    ((def (name arg ...) stmnt ...)
     (define name (lambda (arg ... ) stmnt ...)))
    ((def symbol stmnt)
     (define symbol stmnt))))


(define-syntax whle
  (syntax-rules (do)
     ((whle condition do stmt ...)
      (let loop ()
        (if condition
            (begin stmt ...
                   (loop))
            (display "DONE"))))))


;(let ((x 10))
 ; (whle (> x 0) do (set! x (- x 2))
  ;      (display x)
   ;     (newline)))


(define-macro i++
  (lambda ()
    `(set! i (+ i 1))))

(define-macro i--
  (lambda ()
    `(set! i (- i 1))))

(define-macro i=
  (lambda (num)
    `(set! i ,num)))

(define-syntax FORR
  (syntax-rules (do =)
     ((FORR init cond incr do body ...)
      (begin init
             (let loop ()
               (if cond
                   (begin body ...
                          incr
                          (loop))
                   (void)))))))

(def (fac n)
  (if (= n 0)
      1
      (* n (fac (- n 1)))))


;(let ((i (void)))
;  (FORR (i= 1) (<= i 50) (i++) do
;      (display (fac i))
;      (newline)))

(define-macro for-each
  (lambda (symbol list . body)
    (let ((loopname (gensym))
          (listname (gensym)))
      `(let ,loopname ((,listname ,list))
         (if (not (null? ,listname))
             (let ((,symbol (car ,listname)))
               ,@body
               (,loopname (cdr ,listname))))))))

;(for-each i '(1 0 3) (set! i (+ i 10)) (display i)(newline))

(define-syntax foreach
  (syntax-rules ()
    ((foreach var list stmt ...)
     (let loop ((l list))
       (if (not (null? l))
           (let ((var (car l)))
             (begin stmt ...
                    (loop (cdr l)))))))))

;(foreach i '(1 0 3) (set! i (+ i 10)) (display i) (newline))


(define-syntax AND
  (syntax-rules ()
    ((AND) #t)
    ((AND test) test)
    ((AND test1 test2 ...)
     (if test1 (AND test2 ...) #f))))

;(AND 1 5)

(define-syntax OR
  (syntax-rules ()
    ((OR) #f)
    ((OR test) test)
    ((OR test1 test2 ...)
     (if test1 test1 (OR test2 ...)))))

;(OR (< 5 3) #f)

(define-macro ANDD
  (lambda args
    (if (null? (cdr args))
        (car args)
        `(if ,(car args)
             (ANDD ,@(cdr args))
             #f))))

;(ANDD 5 6 2)


(define-syntax LET*
  (syntax-rules ()
    ((LET* ((var value)) stmt ...)
     ((lambda (var) (begin stmt ...)) value))
    ((LET* ((var1 value1) (var2 value2) ...) stmt ...)
     (let ((var1 value1))
       (LET* ((var2 value2) ...) stmt ...)))))
     

(LET* ((x 10)(y 30))
    (+ x y))




(define-macro LET
  (lambda (values . body)
    (if (null? values)
        body
        `((lambda ,(map car values)
           ,@body)
         ,@(map cadr values)))))

;(LET ((x 10)(y 20))
 ;    (+ x y))

(define-syntax fir
  (syntax-rules (to do from)
    ((fir var to num do stmt ...)
     (let loop ((var 0))
       (if (<= var num)
           (begin stmt ...
           (loop (+ var 1))))))
    ((fir var from num1 to num2 do stmt ...)
     (let loop ((var num1))
       (if (<= var num2)
           (begin stmt ...
           (loop (+ var 1))))))))

;(fir x to 5 do (display x))
;(newline)
;(fir x from 4 to 5 do (display x))


(define stack '(1 2 3))

(define-macro push
  (lambda (symbol value)
    `(begin
       (set! ,symbol (cons ,value ,symbol))
       ,symbol)))

;(push stack 10)

(define-macro pop
  (lambda (symbol)
    `(begin
       (set! ,symbol (cdr ,symbol))
       ,symbol)))

;(pop stack)


(define-macro whale
  (lambda (condition . body)
    (let ((loopname (gensym))
          (last-arg (gensym)))
      `(let ,loopname ((,last-arg (void)))
         (if ,condition
             (,loopname (begin ,@body))
             ,last-arg)))))

;(let ((i 0)
;      (j 0))
;  (whale (< i 10)
;         (set! j (+ j i))
;         (set! i (+ i 1))
;         (list i j)))

(define proc-or
  (lambda args
    (if (null? args)
        #f
        (if (car args) #t
            (apply proc-or (cdr args))))))


(define-syntax multifor
  (syntax-rules (in do)
    ((multifor ((var in values ...) ...) do stmt ...)
     (let loop ((list '((values ...) ...)))
       (if (not (apply proc-or (map null? list)))
           (begin
             (apply
              (lambda (var ...)
                stmt ...)
              (map car list))
             (loop (map cdr list))))))))


;(multifor ((a in 0 1 0 1)
 ;          (b in 0 0 1 1))
  ;        do (display a)
   ;       (display b)
    ;      (newline))


(define-macro bežin
  (lambda args
    (if (null? args)
        (void)
    `((lambda () ,@args)))))

;(bežin (+ 1 2) (+ 5 6))

               
                    
       


