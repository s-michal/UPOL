;point

(defclass point ()
  ((x :initform 0)
   (y :initform 0)))

(defmethod x ((point point))
  (slot-value point 'x))

(defmethod y ((point point))
  (slot-value point 'y))

(defmethod set-x ((point point) val)
  (setf (slot-value point 'x) val))

(defmethod set-y ((point point) val)
  (setf (slot-value point 'y) val))

(defmethod distance ((point1 point) (point2 point))
  (sqrt (+ (expt (- (x point1) (x point2)) 2)
           (expt (- (y point1) (y point2)) 2))))

;circle

(defclass circle ()
  ((center :initform (make-instance 'point))
   (radius :initform 0)))

(defmethod center ((circle circle))
  (slot-value circle 'center))

(defmethod radius ((circle circle))
  (slot-value circle 'radius))

(defmethod set-center ((circle circle) arg)
  (setf (slot-value circle 'center) arg))

(defmethod set-radius ((circle circle) arg)
  (setf (slot-value circle 'radius) arg))

(defmethod distance ((circle circle) point)
  (abs (- (distance (center circle) point) 
     (radius circle))))

(defmethod area ((circle circle))
  (* pi (expt (radius circle) 2)))

;line

(defclass line ()
  ((start :initform (make-instance 'point))
   (end :initform (make-instance 'point))))

(defmethod start ((line line))
  (slot-value line 'start))

(defmethod end ((line line))
  (slot-value line 'end))

(defmethod set-start ((line line) (point point))
  (setf (start line) point))

(defmethod set-end ((line line) (point point))
  (setf (end line) point))

(defmethod size ((line line))
  (distance (start line) (end line)))















