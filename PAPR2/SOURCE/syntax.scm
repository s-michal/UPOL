(require 'macro)

(define-syntax and
 (syntax-rules()
   ((and ) #t)
   ((and test) test)
   ((and test1 text2 ...)
    (if test1 (and test2 ...) #f)))) 


