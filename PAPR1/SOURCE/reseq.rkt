(define reseq
  (lambda (a b n)
   (reverse (let iter ((accum '())
                        (i n))
      (cond ((= i 0) accum)
            ((= i n) (iter (cons a accum) (- i 1)))
            ((= i 1) (iter (cons b accum) (- i 1)))
            (else (iter (cons (+ (/ (+ n 1)) (car accum)) accum) (- i 1))))))))

(reseq 2 6 5)


            