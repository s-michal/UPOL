;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; Zdrojový soubor k učebnímu textu M. Krupka: Objektové programování
;;;;
;;;; Kapitola 7, klikání myší a události
;;;;

#| 
Před načtením souboru načtěte knihovnu micro-graphics
Pokud při načítání (kompilaci) dojde k chybě 
"Reader cannot find package MG",
znamená to, že knihovna micro-graphics není načtená.
|#


;;;
;;; Třída omg-object
;;;

(defclass omg-object () 
  ((delegate :initform nil)))

(defmethod delegate ((obj omg-object))
  (slot-value obj 'delegate))

(defmethod set-delegate ((obj omg-object) delegate)
  (setf (slot-value obj 'delegate) delegate))


;;Funkce has-method-p zjišťuje, zda existuje metoda pro danou
;;zprávu a dané argumenty. Není nutné jí rozumět.
(defun has-method-p (object message arguments)
  (and (fboundp message)              
       (compute-applicable-methods
        (symbol-function message)
        (cons object arguments))))

;; posílání událostí: send-event

(defmethod send-event ((object omg-object) event 
		       &rest event-args)
  (let ((delegate (delegate object)))
    (if (and delegate 
             (has-method-p delegate 
                           event 
                           (cons object event-args)))
        (apply event delegate object event-args)
      object)))

(defmethod change ((object omg-object))
  (send-event object 'ev-change)
  object)

(defmethod changing ((object omg-object))
  (send-event object 'ev-changing)
  object)


;; základní události

(defmethod ev-change ((obj omg-object) sender)
  (change obj))

(defmethod ev-changing ((obj omg-object) sender)
  (changing obj))

(defmethod ev-mouse-down 
           ((obj omg-object) sender clicked button position)
  (send-event obj 'ev-mouse-down clicked button position))


;;;
;;; Třída shape
;;;

(defclass shape (omg-object)
  ((color :initform :black)
   (thickness :initform 1)
   (filledp :initform nil)
   (window :initform nil)))

(defmethod window ((shape shape)) 
  (slot-value shape 'window))

(defmethod set-window ((shape shape) value) 
  (setf (slot-value shape 'window) value)
  shape)

(defmethod shape-mg-window ((shape shape))
  (when (window shape)
    (mg-window (window shape))))

(defmethod color ((shape shape)) 
  (slot-value shape 'color))

(defmethod do-set-color ((shape shape) value)
  (setf (slot-value shape 'color) value))

(defmethod set-color ((shape shape) value) 
  (changing shape)
  (do-set-color shape value)
  (change shape)) 

(defmethod thickness ((shape shape)) 
  (slot-value shape 'thickness)) 

(defmethod do-set-thickness ((shape shape) value) 
  (setf (slot-value shape 'thickness) value)) 

(defmethod set-thickness ((shape shape) value)
  (changing shape)
  (do-set-thickness shape value)
  (change shape))

(defmethod filledp ((shape shape))
  (slot-value shape 'filledp))

(defmethod do-set-filledp ((shape shape) value)
  (setf (slot-value shape 'filledp) value))

(defmethod set-filledp ((shape shape) value)
  (changing shape)
  (do-set-filledp shape value)
  (change shape))

(defmethod do-move ((shape shape) dx dy)
  shape)

(defmethod move ((shape shape) dx dy)
  (changing shape)
  (do-move shape dx dy)
  (change shape))

(defmethod do-rotate ((shape shape) angle center)
  shape)

(defmethod rotate ((shape shape) angle center)
  (changing shape)
  (do-rotate shape angle center)
  (change shape))

(defmethod do-scale ((shape shape) coeff center)
  shape)

(defmethod scale ((shape shape) coeff center)
  (changing shape)
  (do-scale shape coeff center)
  (change shape))


(defmethod set-mg-params ((shape shape)) 
  (let ((mgw (shape-mg-window shape)))
    (mg:set-param mgw :foreground (color shape)) 
    (mg:set-param mgw :filledp (filledp shape))
    (mg:set-param mgw :thickness (thickness shape)))
  shape)

(defmethod do-draw ((shape shape)) 
  shape)

(defmethod draw ((shape shape))
  (set-mg-params shape)
  (do-draw shape))


;;; Práce s myší

(defmethod solidp ((shape shape))
  t)

(defmethod solid-shapes ((shape shape))
  (if (solidp shape)
      (list shape)
    (solid-subshapes shape)))

(defmethod solid-subshapes ((shape shape))
  (error "Method has to be rewritten."))


(defmethod contains-point-p ((shape shape) point)
  nil)

(defmethod mouse-down ((shape shape) button position)
  (send-event shape 'ev-mouse-down shape button position))


;;;
;;; Třída point
;;;

(defclass point (shape) 
  ((x :initform 0) 
   (y :initform 0)))

(defmethod x ((point point))
  (slot-value point 'x))

(defmethod y ((point point))
  (slot-value point 'y))

(defmethod do-set-x ((point point) value)
  (setf (slot-value point 'x) value))

(defmethod set-x ((point point) value)
  (unless (typep value 'number)
    (error "x coordinate of a point should be a number"))
  (changing point)
  (do-set-x point value)
  (change point))

(defmethod do-set-y ((point point) value)
  (setf (slot-value point 'y) value))

(defmethod set-y ((point point) value)
  (unless (typep value 'number)
    (error "y coordinate of a point should be a number"))
  (changing point)
  (do-set-y point value)
  (change point))

(defmethod r ((point point)) 
  (let ((x (slot-value point 'x)) 
        (y (slot-value point 'y))) 
    (sqrt (+ (* x x) (* y y)))))

(defmethod phi ((point point)) 
  (let ((x (slot-value point 'x)) 
        (y (slot-value point 'y))) 
    (cond ((> x 0) (atan (/ y x))) 
          ((< x 0) (+ pi (atan (/ y x)))) 
          (t (* (signum y) (/ pi 2))))))

(defmethod set-r-phi ((point point) r phi) 
  (set-x point (* r (cos phi)))
  (set-y point (* r (sin phi)))
  point)

(defmethod set-r ((point point) value) 
  (set-r-phi point value (phi point)))

(defmethod set-phi ((point point) value) 
  (set-r-phi point (r point) value))

(defmethod set-mg-params ((pt point))
  (call-next-method)
  (mg:set-param (shape-mg-window pt) :filledp t)
  pt)

(defmethod do-draw ((pt point)) 
  (mg:draw-circle (shape-mg-window pt) 
                  (x pt) 
                  (y pt) 
                  (thickness pt))
  pt)

(defmethod do-move ((pt point) dx dy)
  (set-x pt (+ (x pt) dx))
  (set-y pt (+ (y pt) dy))
  pt)

(defmethod do-rotate ((pt point) angle center)
  (let ((cx (x center))
        (cy (y center)))
    (move pt (- cx) (- cy))
    (set-phi pt (+ (phi pt) angle))
    (move pt cx cy)
    pt))

(defmethod do-scale ((pt point) coeff center)
  (let ((cx (x center))
        (cy (y center)))
    (move pt (- cx) (- cy))
    (set-r pt (* (r pt) coeff))
    (move pt cx cy)
    pt))


;; Práce s myší

;; Pomocné funkce (vzdálenost bodů)

(defun sqr (x)
  (expt x 2))

(defun point-dist (pt1 pt2)
  (sqrt (+ (sqr (- (x pt1) (x pt2)))
           (sqr (- (y pt1) (y pt2))))))

(defmethod contains-point-p ((shape point) point)
  (<= (point-dist shape point) 
      (thickness shape)))


;;;
;;; Třída circle
;;;

(defclass circle (shape) 
  ((center :initform (make-instance 'point)) 
   (radius :initform 1)))

(defmethod initialize-instance ((c circle) &key)
  (call-next-method)
  (set-delegate (center c) c))

(defmethod radius ((c circle))
  (slot-value c 'radius))

(defmethod do-set-radius ((c circle) value)
  (setf (slot-value c 'radius) value))

(defmethod set-radius ((c circle) value)
  (when (< value 0)
    (error "Circle radius should be a non-negative number"))
  (changing c)
  (do-set-radius c value)
  (change c))

(defmethod center ((c circle))
  (slot-value c 'center))

(defmethod do-draw ((c circle))
  (mg:draw-circle (shape-mg-window c)
                  (x (center c))
                  (y (center c))
                  (radius c))
  c)

(defmethod do-move ((c circle) dx dy)
  (move (center c) dx dy)
  c)

(defmethod do-rotate ((c circle) angle center)
  (rotate (center c) angle center)
  c)

(defmethod do-scale ((c circle) coeff center)
  (scale (center c) coeff center)
  (set-radius c (* (radius c) coeff))
  c)



;; Práce s myší

(defmethod contains-point-p ((circle circle) point)
  (let ((dist (point-dist (center circle) point))
        (half-thickness (/ (thickness circle) 2)))
    (if (filledp circle)
        (<= dist (radius circle))
      (<= (- (radius circle) half-thickness)
          dist
          (+ (radius circle) half-thickness)))))


;;;
;;; Třída compound-shape
;;;

(defclass compound-shape (shape)
  ((items :initform '())))

(defmethod items ((shape compound-shape)) 
  (copy-list (slot-value shape 'items)))

(defmethod send-to-items ((shape compound-shape) 
			  message
			  &rest arguments)
  (dolist (item (items shape))
    (apply message item arguments))
  shape)

(defmethod check-item ((shape compound-shape) item)
  (error "Method should be rewritten."))

(defmethod check-items ((shape compound-shape) item-list)
  (dolist (item item-list)
    (check-item shape item))
  shape)

(defmethod do-set-items ((shape compound-shape) value)
  (setf (slot-value shape 'items) (copy-list value))
  (send-to-items shape #'set-delegate shape))

(defmethod set-items ((shape compound-shape) value)
  (check-items shape value)
  (changing shape)
  (do-set-items shape value)
  (change shape))

(defmethod do-move ((shape compound-shape) dx dy)
  (send-to-items shape #'move dx dy)
  shape)

(defmethod do-rotate ((shape compound-shape) angle center)
  (send-to-items shape #'rotate angle center)
  shape)

(defmethod do-scale ((shape compound-shape) coeff center)
  (send-to-items shape 'scale coeff center)
  shape)


;;;
;;; Třída picture
;;;

(defclass picture (compound-shape)
  ())

(defmethod check-item ((pic picture) item)
  (unless (typep item 'shape)
    (error "Invalid picture element type."))
  pic)

(defmethod do-set-items ((shape picture) value)
  (call-next-method)
  (send-to-items shape #'set-window (window shape)))

(defmethod draw ((pic picture))
  (dolist (item (reverse (items pic)))
    (draw item))
  pic)

(defmethod set-window ((shape picture) value)
  (send-to-items shape 'set-window value)
  (call-next-method))


;; Práce s myší

(defmethod solidp ((pic picture))
  nil)

(defmethod solid-subshapes ((shape picture))
  (mapcan 'solid-shapes (items shape)))

(defmethod contains-point-p ((pic picture) point)
  (find-if (lambda (item)
	     (contains-point-p item point))
	   (items pic)))


;;;
;;; Třída polygon
;;;

(defclass polygon (compound-shape)
  ((closedp :initform t)))

(defmethod check-item ((poly polygon) item)
  (unless (typep item 'point) 
    (error "Items of polygon should be points."))
  poly)

(defmethod closedp ((p polygon))
  (slot-value p 'closedp))

(defmethod do-set-closedp ((p polygon) value)
  (setf (slot-value p 'closedp) value))

(defmethod set-closedp ((p polygon) value)
  (changing p)
  (do-set-closedp p value)
  (change p))

(defmethod set-mg-params ((poly polygon)) 
  (call-next-method)
  (mg:set-param (shape-mg-window poly) 
                :closedp
                (closedp poly))
  poly)

(defmethod polygon-coordinates ((p polygon))
  (let (coordinates)
    (dolist (point (reverse (items p)))
      (setf coordinates (cons (y point) coordinates)
            coordinates (cons (x point) coordinates)))
    coordinates))

(defmethod do-draw ((poly polygon)) 
  (mg:draw-polygon (shape-mg-window poly) 
                   (polygon-coordinates poly))
  poly)


;;
;; contains-point-p pro polygon využívá funkci
;; mg:point-in-polygon-p knihovny micro-graphics.
;;

(defmethod contains-point-p ((poly polygon) point)
  (mg:point-in-polygon-p (x point) (y point) 
                         (closedp poly)
                         (filledp poly) 
                         (thickness poly)
                         (polygon-coordinates poly)))


;;;
;;; Třída window
;;;

(defclass window (omg-object)
  ((mg-window :initform (mg:display-window))
   (shape :initform nil)
   (background :initform :white)))

(defmethod mg-window ((window window))
  (slot-value window 'mg-window))

(defmethod shape ((w window))
  (slot-value w 'shape))

(defmethod set-shape ((w window) shape)
  (changing w)
  (when shape
    (set-window shape w)
    (set-delegate shape w))
  (setf (slot-value w 'shape) shape)
  (change w))

(defmethod background ((w window))
  (slot-value w 'background))

(defmethod set-background ((w window) color)
  (changing w)
  (setf (slot-value w 'background) color)
  (change w))

(defmethod invalidate ((w window))
  (mg:invalidate (mg-window w))
  w)

(defmethod change ((w window))
  (invalidate w)
  (call-next-method))

(defmethod redraw ((window window))
  (let ((mgw (mg-window window)))
    (mg:set-param mgw :background (background window))
    (mg:clear mgw)
    (when (shape window)
      (draw (shape window))))
  window)


;; Klikání

(defmethod find-clicked-shape ((w window) position)
  (when (shape w)
    (find-if (lambda (shape) 
               (contains-point-p shape position))
             (solid-shapes (shape w)))))

(defmethod mouse-down-inside-shape 
           ((w window) shape button position)
  (mouse-down shape button position)
  w)

(defmethod mouse-down-no-shape ((w window) button position)
  w)

(defmethod window-mouse-down ((w window) button position)
  (let ((shape (find-clicked-shape w position)))
    (if shape
        (mouse-down-inside-shape w shape button position)
      (mouse-down-no-shape w button position))))


;; Inicializace

(defmethod install-display-callback ((w window))
  (mg:set-callback (mg-window w)
		   :display (lambda (mgw)
                              (declare (ignore mgw))
                              (redraw w)))
  w)

(defmethod install-mouse-down-callback ((w window))
  (mg:set-callback 
   (mg-window w) 
   :mouse-down (lambda (mgw button x y)
		 (declare (ignore mgw))
		 (window-mouse-down 
                  w
                  button 
                  (move (make-instance 'point) x y)))))

(defmethod install-callbacks ((w window))
  (install-display-callback w)
  (install-mouse-down-callback w)
  w)

(defmethod initialize-instance ((w window) &key)
  (call-next-method)
  (install-callbacks w)
  w)



