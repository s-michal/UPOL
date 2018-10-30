(define project
  (lambda (x y)
    (map (lambda (l)
           (list (list-ref l y)))x)))

(define add
  (lambda (x y)
    (append y x)))

(define merge
  (lambda (x y)
    (append x y)))

(define join
  (lambda (x y)
    (map append x y)))
