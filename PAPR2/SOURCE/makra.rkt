(define new-if-trans
  (lambda (<test> <expr> . <alt>)
    (list 'if <test> <expr>
          (if (null? <alt>)
              #f
              (car <alt>)))))

;(new-if-trans 'e1 'e2 'e3)
;(new-if-trans 'e1 'e2)

(define-macro if
  (lambda (test expr . alt)
    `(cond (,test ,expr)
           (else (begin #f ,@alt))) ))

;(if 10 10)

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



;(prox 5)

(define aux '())


(define remember
 (lambda (elem)
   (if elem
       (begin
         (set! aux (cons (list elem) aux))
         aux)
       aux)))

(define forget
  (lambda ()
    (if (null? aux)
        aux
        (begin
          (set! aux '())
          (display "FORGOTTEN")
          (newline)))))

(remember 5)
(remember 4)
(remember 3)
(forget)
(remember 1)
(remember 4)
(remember 3)