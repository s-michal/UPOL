;(uniq '(a b b a)) - > (b a)
;(uniq '(b a b a)) - > (b a)

(define uniq
  (lambda (l)
    (let iter ((accum '())
               )
      (if (null? l)
          accum
          (iter (if (member? (car l) accum)
                    (car l)
                    (cons (car l) accum)))))))



              