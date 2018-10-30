(define counter 0)

(define nasob
  (lambda args
    (set! counter (+ 1 counter))
    (apply * args)))

(define x 100)
(begin
  (define x 10)
  (* 2 x))
x

(for-each
 (lambda (x)
   (display "Cislo:")
   (display x)
   (newline))
 '(1 2 3 4 5))

(for-each
(lambda (x y z)
(newline)
(display (list x y z))
(newline))
'(10 20) '(#t #f) '(a b))

(let ((i 0))
(for-each
(lambda (x)
(display "Index: ")
(display i)
(display " , prvek: ")
(display x)
(newline)
(set! i (+ i 1)))
'(a b c d e f)))

(define value 0)

(define inc
(lambda (x)
(set! value (+ value x))
value))

(inc 10)
(inc 10)
(inc 10)

(fluid-let ((value 200))
    (display (inc 10))
    (newline)
    (display (inc 10))
    (newline))

(inc 10)


(define ink
(lambda (x)
(let ((value 0))
(set! value (+ value x))
value)))

(ink 5)
(ink 5)




;define create!
 ; (lambda ()
  ;    (define name 
   ;     (lambda (name list)
    ;      (set! name list)))))

(define value '())

;(define create!
;  (lambda (name list)
;    (begin
;      (set! name list)
;      (set! value name)
;      (display "new table was created")
;      (newline))))

(define jmeno '())
(define seznam '())

(define create!
  (lambda (name list)
    (set! jmeno name)
    (set! seznam list)))
    
(create! 'test '((a 1) (b 2) (c 3)))





(define table
  (lambda (name)
    (if (null? name)
        #f
        name)))

(define drop!
  (lambda (name)
    (set! name '())))






