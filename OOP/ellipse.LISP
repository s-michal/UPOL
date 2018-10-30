(defclass ellipse () 
  ((focal-point1 :initform (make-instance 'point))
   (focal-point2 :initform (make-instance 'point))
   (major-semiaxis :initform 1)
   (minor-semiaxis :initform 1)
   (current-center :initform (make-instance 'point))))

(defun distance (point1 point2)
  (sqrt (+ (expt (- (x point1) (x point2)) 2)
           (expt (- (y point1) (y point2)) 2))))

(defmethod focal-point1 ((el ellipse))
  (slot-value el 'focal-point1))

(defmethod focal-point2 ((el ellipse))
  (slot-value el 'focal-point2))

(defmethod set-focal-point1 ((el ellipse) value)
  (setf (slot-value el 'focal-point1) value)
  el)

(defmethod set-focal-point2 ((el ellipse) value)
  (setf (slot-value el 'focal-point2) value)
  el)

(defmethod major-semiaxis ((el ellipse))
  (slot-value el 'major-semiaxis))

(defmethod minor-semiaxis ((el ellipse))
  (slot-value el 'minor-semiaxis))

(defmethod set-major-semiaxis ((el ellipse) value)
  (let ((c (distance (focal-point2 el) (current-center el))))
    (setf (slot-value el 'major-semiaxis) value)
    (let ((a (major-semiaxis el)))
          (setf (slot-value el 'minor-semiaxis) (sqrt (- (expt a 2) (expt c 2))))
          el)))

(defmethod set-minor-semiaxis ((el ellipse) value)
  (let ((c (distance (focal-point2 el) (current-center el))))
    (setf (slot-value el 'minor-semiaxis) value)
    (let ((a (minor-semiaxis el)))
          (setf (slot-value el 'major-semiaxis) (sqrt (+ (expt a 2) (expt c 2))))
          el)))

(defmethod current-center ((el ellipse))
  (slot-value el 'current-center))  

(defmethod set-current-center ((el ellipse) center)
  (setf (slot-value el 'current-center) center))

(defmethod eccentricity ((el ellipse))
 (let ((distance (distance (focal-point1 el) (focal-point2 el))))
   (/ distance (* 2 (major-semiaxis el)))))

(defmethod to-ellipse ((cir circle))
  (let ((el (make-instance 'ellipse)))
    (progn
      (set-focal-point1 el (center cir))
      (set-focal-point2 el (center cir))
      (set-current-center el (center cir))
      (set-major-semiaxis el (radius cir)))
  el))



