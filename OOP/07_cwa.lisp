;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; 07_cwa.lisp - příklad ke kapitole 7
;;;;

#|

Třída circle-with-arrow. 
Jednoduchá ukázka použití objektu jako tlačítka a události ev-mouse-down.

Kromě standardních souborů je třeba načíst soubor 07_click-circle.lisp

|#

(defun make-point (x y)
  (move (make-instance 'point) x y))

(defun make-polygon (x-list y-list filledp closedp color)
  (set-closedp (set-filledp
                (set-color
                 (set-items (make-instance 'polygon)
                            (mapcar 'make-point x-list y-list))
                 color)
                filledp)
               closedp))

(defun make-arrow (color)
  (make-polygon '(0 0 30 30 0 0 -30)
                '(-30 -15 -15 15 15 30 0)
                t
                t
                color))

(defun cwa-items ()
  (list (move (set-filledp (set-radius (make-instance 'click-circle)
                                       40)
                           t)
              148
              60)
        (move (rotate (make-arrow :blue)
                      0
                      (make-instance 'point))
              100
              150)
         (move (rotate (make-arrow :blue)
                       pi
                      (make-instance 'point))
              170
              150)))

(defclass circle-with-arrow (picture)
  ())

(defmethod initialize-instance ((pic circle-with-arrow) &key)
  (call-next-method)
  (set-items pic (cwa-items))
  pic)

(defmethod cwa-circle ((p circle-with-arrow))
  (first (items p)))

(defmethod cwa-arrow-left ((p circle-with-arrow))
  (second (items p)))

(defmethod cwa-arrow-right ((p circle-with-arrow))
  (third (items p)))

(defmethod ev-mouse-down ((p circle-with-arrow) sender origin button position)
  (when (eql sender (cwa-arrow-left p))
    (move (cwa-circle p) -10 0))
  (when (eql sender (cwa-arrow-right p))
    (move (cwa-circle p) 10 0))
  (call-next-method))

#|
(setf cwa (make-instance 'circle-with-arrow))
(setf w (make-instance 'window))
(set-shape w cwa)
;;(klikat lze na šipku i kolečko)
|#