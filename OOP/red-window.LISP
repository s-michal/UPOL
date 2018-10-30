(defclass red-window (window)
  ())

(defun make-lights (lights-num)
  (let ((items '())
        (move-y 50))
    (dotimes (x lights-num)
      (setf light (move (set-radius (make-instance 'circle)
                                    20) 50 move-y))
      (setf move-y (+ move-y 50))
      (setf items (cons light items)))
    items))







