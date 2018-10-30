(defun isPrime (num)
  (cond ((<= num 1) 0)
        ((= num 2) nil)
        ((> num 1)
         (loop for x from 2 to (- num 1) do
               (when (= (mod num x) 0)
                 (return 0))))))

(defun primep (num)
  (cond ((eql 0 (isPrime num)) 0)
        ((eql nil (isPrime num)) 1)))

(defun primeNum (num)
  (loop for x from 0 to num do
        (if (equalp (primep x) 1)
            (print x))))
      

;5


        
                