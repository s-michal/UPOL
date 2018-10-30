(define-syntax AND
  (syntax-rules ()
    ((AND) #t)
    ((AND test) test)
    ((AND test1 test2 ...)
     (if test1 (and test2 ...) #f))))

;(AND 5 10 #f 30 50)

(define-syntax OR
  (syntax-rules ()
    ((OR) #f)
    ((OR test) test)
    ((OR test1 test2 ...)
     (if test1 test1 (OR test2 ...)))))

;(OR #f #f #f)

;(foreach cislo in '(1 4 5 7) do (display cislo) (newline))



(define-syntax foreach
  (syntax-rules (in do)
    ((foreach var in list do statement ...)
     (let loop ((values list))
       (if (not (null? values))
           (let ((var (car values)))
             statement ...
             (loop (cdr values))))))))

;(foreach cislo in '(1 4 5 7) do (display cislo) (newline))

;(multifor ((a in 0 1 0 1) (b in 0 0 1 1)) do (display a) (display b) (newline))

(define-syntax multifor
  (syntax-rules (in do)
    ((multifor ((var in values ...) ...) do statement ...)
     (let loop ((symbols '((values ...) ...)))
       (if (not (apply proc-or (map null? values)))
           (begin
             (apply (lambda (var ...)
                      statement ...)
                    (map car values))
             (loop (map cdr l))))))))

     