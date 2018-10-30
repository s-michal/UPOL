(define mlist
  (lambda args
    (if (null? args)
        '()
        (mcons (car args) (apply mlist (cdr args))))))


(define length
  (lambda (l)
    (if (null? l)
        0
        (+ 1 (length (mcdr l))))))

(define cycle!
  (lambda (l)
    (let iter ((aux l))
      (if (null? (mcdr aux))
          (set-mcdr! aux l)
          (iter (mcdr aux))))))

(define seznam (apply mlist '(1 2 3)))
seznam
(cycle! seznam)
seznam

(define cyclic?
  (lambda (l)
    (let test ((rest (mcdr l)))
      (cond ((null? rest) #f)
            ((eqv? rest l) #t)
            (else (test (mcdr rest)))))))

(define s (apply mlist '(4 5)))
(cyclic? s)
(cyclic? seznam)

(define x (apply mlist '(1 2 3)))
(set-mcar! (mcdr x) x)
x

(define depth-cyclic?
  (lambda (l)
    (let ((found '()))
      (let test ((l l))
        (if (pair? l)
            (if (memq l found)
                #t
                (begin
                  (set! found (cons l found))
                  (or (test (car l))
                      (test (cdr l)))))
            #f)))))

(depth-cyclic? x)
(cyclic? x)

(define consd
  (lambda (elem dlist)
    (let ((new-cell (mcons elem (mcons '() dlist))))
      (if (not (null? dlist))
          (set-mcar! (mcdr dlist) new-cell)
          new-cell))))

(define s (consd 'c (consd 'd '())))
s

(define make-box
  (lambda (value)
    (lambda (signal . newvalue)
      (cond ((equal? signal 'get) value)
            ((equal? signal 'set)
             (set! value (car newvalue)))
            (else (error "WRONG INput"))))))

(define val (make-box 10))
(val 'get)
(val 'set 500)
(val 'get)


(define-macro if-new
  (lambda (first second . rest)
    `(if ,first
         ,second
         (begin #f ,@rest))))

(if-new #f 20 160)


(define-macro AD
  (lambda args
    (if (null? args)
        #t
        (if (null? (cdr args))
            (car args)
        `(let ((result ,(car args)))
           (if result
               (AD ,@(cdr args))
               #f))))))

;(AD 10 result 2 result)

(define-macro andd
  (lambda args
    (if (null? (cdr args))
        (car args)
        `(if ,(car args)
             (andd ,@(cdr args))
             #f))))

;(andd 1 2 3 4 5)

(define-macro LETS
  (lambda (sym assign . body)
    `((lambda ()
        (define ,sym
          (lambda ,(map car assign)
            (begin ,@body)))
        (,sym ,@(map cadr assign))))))

(member 10 '(1 2 3 10))

(define-macro while
  (lambda (condition . body)
    `(call/cc
      (lambda (break)
        (let loop ((last (void)))
          (if ,condition
              (loop (begin ,@body))
              last))))))

(let ((x 0))
  (while (< x 10)
         (begin
           (set! x (+ x 1))
           (if (= x 5)
               (break)))
           (list x)))


(define-macro for
  (lambda (init condition incr . body)
    `(begin
       ,init
       (let loop ()
         (if ,condition
             (begin ,@body
                    ,incr
                    (loop)))))))


(let ((i 0)
      (result 0))
  (for (set! i 5)
    (> i 0)
    (set! i (- i 1))
    (display (list "Stav: " i result))
    (newline)
    (set! result (+ result 1)))
    (display (list "Koncovy: " i result))
    (newline))


(define-syntax and
  (syntax-rules ()
    ((and) #t)
    ((and test) test)
    ((and test1 test2 ...)
     (if test1 (and test2 ...) #f))))


(define-syntax OR
  (syntax-rules ()
    ((OR) #f)
    ((OR test) test)
    ((OR test1 test2 ...)
     (if test1 test1 (OR test2 ...)))))

(OR #f 2 3)


(letrec-syntax
    ((A (syntax-rules ()
          ((A) #t)
          ((A test) test)
          ((A test1 test2 ...)
           (if test1 (A test2 ...) #f)))))
  (A 1 2 3))


(define struct (apply mlist '(1 2 3 4 5)))
struct

(set-mcar! (mcdr struct) 10)
struct
(set-mcdr! struct 20)
struct

(define x (delay '(1 2 3)))
x
(force x)

(define-macro freeze
  (lambda args
    `(lambda ()
       (begin ,@args))))

(define new (freeze (+ 1 3)))
new

(define thaw
  (lambda (promise)
    (promise)))

(thaw new)

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

(define pf (delay '(1 2 3)))
pf
(thaw pf)
(define force thaw)

(define-macro stream-cons
  (lambda (x y)
    `(cons ,x (delay ,y))))

(display "-----------------------")
(newline)

(define stream (stream-cons 'a 'b))
(force (cdr stream))
(car stream)


(define promise?
  (lambda (elem)
    (if (procedure? elem)
        #t
        #f)))


(define try (delay '(1 2 3)))
try
(promise? try)

(define stream?
  (lambda (elem)
    (or (null? elem)
        (and (pair? elem)
             (and (promise? (cdr elem))
                  (stream? (force (cdr elem))))))))

(stream? stream)

(define stream-cdr
  (lambda (stream)
    (force (cdr stream))))


(define blah (stream-cons 'a (stream-cons 'b (stream-cons 'c '()))))

(define display-stream
  (lambda (s n)
    (if (null? s)
        (void)
        (if (= n 0)
        (void)
          (begin (display (car s))
                 (display ", ")
                 (display-stream (stream-cdr s) (- n 1)))))))

(display-stream blah 3)
(newline)

(define naturalss
  (lambda ()
    (let iter ((num 0))
      (stream-cons num (iter (+ num 1))))))

(define numbers (naturalss))
(display-stream numbers 100)

(define negativs
  (lambda ()
    (let iter ((num 0))
      (stream-cons num (iter (- num 1))))))

(define numbex (negativs))
(display-stream numbex 100)

(define stream-null? null?)
(define stream-car car)

(define stream-map
  (lambda (f stream)
    (if (stream-null? stream)
        '()
        (stream-cons
         (f (stream-car stream))
         (stream-map f (stream-cdr stream))))))


(define build-stream
  (lambda (f n)
        (let iter ((first 0)
                   (n n))
          (if (= n 0)
             '()
             (stream-cons (f first)
                          (iter (+ first 1) (- n 1)))))))
(newline)
(define negs (build-stream + 10))
(display-stream negs 10)
(define else (stream-map - negs))
(newline)
(display-stream else 10)
(newline)

              
(define whoa '(1 2 3 4))
(define list->stream
  (lambda (list)
    (foldr (lambda (x y)
             (stream-cons x y ))
           '() list)))

(define str (list->stream whoa))
(stream-car str)

(define stream-length
  (lambda (stream)
    (if (stream-null? stream)
        0
        (+ 1 (stream-length (stream-cdr stream))))))

(stream-length str)

(define stream-foldr
  (lambda (f nil . streams)
    (if (stream-null? (stream-car streams))
        nil
        (apply f
               `(,@(map stream-car streams)
                  ,(delay
                    (apply stream-foldr f nil
                           (map stream-cdr streams))))))))

(define stream->list
  (lambda (stream)
    (stream-foldr (lambda (x y)
             (cons x (force y)))
           '()
           stream)))

(define pow2
  (stream-cons 1
               (stream-map (lambda (x) (* 2 x))
                           pow2)))

(display-stream pow2 10)

(define ones (stream-cons 1 ones))

(define expand-stream
  (lambda (stream . modifiers)
    (let iter ((pending modifiers))
      (if (null? pending)
          (apply expand-stream
                 (stream-cdr stream) modifiers)
          (stream-cons ((car pending) (stream-car stream))
                       (iter (cdr pending)))))))

(define www (expand-stream ones (lambda (x) (* 10 x)) -))
(display-stream www 20)
(newline)

(call/cc (lambda (f) (+ 10 (f 2))))

(define list-product
  (lambda (l)
    (if (null? l)
    1
    (* (car l) (list-product (cdr l))))))

(list-product '(1 2 3))

(define list-pro
  (lambda (l)
    (call/cc
     (lambda (exit)
       (let proc ((l l))
         (cond ((null? l) 1)
               ((= (car l) 0) (exit 0))
               (else (* (car l) (proc (cdr l))))))))))

(list-pro '(1 2 3))

;(call/cc (lambda (f) f))

(define blas #f)

(* 2 (call/cc
      (lambda (f)
        (set! blas f)
      30)))

blas
(blas 20)

(define uhh #f)

(call/cc
 (lambda (f)
   (set! uhh f)))


(define-macro WHILE
  (lambda (condition . body)
    (let ((loop-name (gensym)))
      `(call/cc
        (lambda (break)
          (let ,loop-name ()
            (if ,condition
                (begin
                  (call/cc
                   (lambda (continue)
                     (let ((redo #f))
                       (call/cc
                        (lambda (f)
                          (set! redo f)))
                     ,@body)))
                       (,loop-name)))))))))

(let ((i 0)
      (j 0))
  (while (< i 10)
         (set! j (+ j i))
         (set! i (+ i 1))
         (if (> i 5)
             (break)))
  (list i j))

(define amb-fail
  (let ((failure #f))
    (lambda args
      (if (null? args)
          failure
          (set! failure
                (if (procedure? (car args))
                    (car args)
                    (lambda ()
                      (error "AMB: Tree exhausted"))))))))

(amb-fail #f)
(amb-fail (lambda (x)
            (amb-fail odd?)
            x))

((amb-fail) 10)


(define sop (stream-cons 1 (stream-map (lambda (x) (* x 10))
                        sop)))

(display-stream sop 10)

(define s (apply mlist '(1 2 3)))
(set-mcar! s 10)
s
(set-mcar! (mcdr s) 20)
s
(set-mcar! (mcdr (mcdr s)) 30)
s

(define list-set!
  (lambda (l index value)
    (let iter ((l l)
               (i index))
      (if (= i 0)
          (set-mcar! l value)
          (iter (mcdr l) (- i 1))))
    l))

(list-set! s 2 50)

(define streamm?
  (lambda (stream)
         (or (null? stream)
             (and (pair? elem)
                  (and (promise? (cdr stream))
                       (stream? (force (cdr stream))))))))

(define assox!
  (lambda (assoc key val)
    (let iter ((as assoc))
      (if (null? as)
          (set-mcdr! assoc (cons (cons key val) (mcdr as)))
          (cons ((equal? (caar as) key)
                 (set-mcdr! (car as) val))
                (else (iter (mcdr as))))))))

(assoc '(a . a) '((a . a) (b . b)))
