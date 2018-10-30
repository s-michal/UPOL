(define length
  (lambda (x)
    (apply + (map (lambda (i) 1) x))))

(define length2
  (lambda (x)
    (foldr (lambda (x y) (+ y 1)) 0 x)))

(length '(1 5 4 2 6 4))
(length2 '(1 5 4 2 6 4))

(define append2
  (lambda (l1 l2)
    (let ((len1 (length l1))
          (len2 (length l2)))
      (build-list (+ len1 len2)
                  (lambda (i)
                    (if (< i len1)
                        (list-ref l1 i)
                        (list-ref l2 (- i len1))))))))

(append2 '(1 2 3) '(4 5 6))

(define append3
  (lambda (l1 l2)
    (foldr cons l2 l1)))

(append3 '(1 2 3) '(4 5 6))


(define map1
  (lambda (f l)
    (build-list
     (length l)
     (lambda (i)
       (f (list-ref l i))))))

(map1 (lambda (x) (+ x 1)) '(1 2 3))

(define map2
  (lambda (f l)
    (foldr (lambda (x y) (f x))
           '()
           l)))

(map1 (lambda (x) (/ x 10)) '(4 5 6))


(define filter1
  (lambda (p l)
    (apply append
           (map (lambda (i)
                  (if (p i)
                      (list i)
                      '()))
                l))))

(filter even? '(4 5 1 2))

(define filter2
  (lambda (f l)
    (foldr (lambda (x y)
             (if (f x)
                 (list x)
                 '()))
           l)))

(filter even? '(4 5 1 2))

(foldr + 0 '(1 2 3) '(4 5 6))

(define add
  (lambda args
    (foldr (lambda (x y) (+ x y)) 0 args)))

(add 5 5 5 5)

(define lengthh
  (lambda (f)
    (foldl (lambda (x y) (+ 1 y)) 0 f)))

(lengthh '(4 5 1 6 4))

(define revert
  (lambda (l)
    (foldl cons '() l)))

(revert '(4 5 1 6))

(define gen
  (lambda (f term l)
    (foldr (lambda (x y) (f y x))
           term
           (reverse l)
           )))

(gen + 0 '(1 2 3))

(build-list 10 (lambda (x)(+ x 1)))