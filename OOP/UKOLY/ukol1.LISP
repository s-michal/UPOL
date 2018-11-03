;point

(defun make-point ()
  (list (list 0 0) :black))

(defun x (point)
  (caar point))

(defun y (point)
  (cadar point))

(defun set-x (obj arg)
  (setf (caar obj) arg)
  obj)

(defun set-y (obj arg)
  (setf (cadar obj) arg)
  obj)

;circle

(defun make-circle ()
  (let ((center (make-point)))
    (list (list center 0) :black)))
 
(defun center (circle)
  (caar circle))

(defun radius (circle)
  (cadar circle))

(defun set-radius (circle arg)
  (setf (cadar circle) arg)
  circle)

;polygon

(defun make-polygon ()
  (list () :black))

(defun items (obj) 
  (car obj))

(defun set-items (obj list)
  (setf (car obj) list)
  obj)

;picture

(defun make-picture ()
  (list () :black))

;colors 

(defun color (obj)
  (second obj))

(defun set-color (obj color)
  (setf (second obj) color)
  obj)

;move

(defun pointp (obj)
  (if (numberp (caar obj))
      t 
    nil))

(defun move-x (obj arg)
  (set-x obj (+ (x obj) arg)))

(defun move-y (obj arg)
  (set-y obj (+ (y obj) arg)))

(defun move (obj arg1 arg2)
  (if (pointp obj)
      (progn
        (move-x obj arg1)
        (move-y obj arg2))
    (dolist (lst (car obj))
      (when (listp lst)
        (move lst arg1 arg2))))
  obj)
    







