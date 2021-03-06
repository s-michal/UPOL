#|

DOKUMENTACE
-----------

TŘÍDA SEMAPHORE
---------------

Třída semaphore je potomkem třídy picture. Její instance představují semafor,
který se skládá z určitého počtu světel a má různé fáze.

NOVÉ VLASTNOSTI

semaphore-type semaphore       Typ semaforu.
semaphore-phase semaphore      Momentální fáze semaforu.
phase-count semaphore          Počet fází semaforu.

NOVÉ ZPRÁVY

set-semaphore-type semaphore type       Nastaví typ semaforu.
set-semaphore-phase semaphore  phase    Nastaví momentální fázi semaforu.
set-phase-count semaphore count         Nastaví počet fází semaforu.
next-phase semaphore                    Přepne fázi semaforu na následující v pořadí.

TŘÍDA CROSSROADS
---------------

Třída crossroads je potomkem třídy picture. Její instance představují křižovatku,
který se skládá z libovolných objektů z nichž některé mohou být semafory. Křižovatka 
má také svoji fázi.

NOVÉ VLASTNOSTI

semaphores crossroads          Semafory v křižovatece. Jen ke čtení.
crossroads-phase crossroads    Momentální fáze křižovatky.
phase-count crossroads         Počet fází křižovatky.
program crossroads             Program křižovatky.

NOVÉ ZPRÁVY

set-crossroads-phase crossroads  phase       Nastaví momentální fázi křižovatky.
set-phase-count crossroads count             Nastaví počet fází křižovatky.
set-program crossroads program               Nastaví program křižovatky.
next-phase semaphore                         Přepne fázi křižovatky na následující v pořadí.

UPRAVENÉ ZDĚDĚNÉ ZPRÁVY

set-items crossroads items      Navíc se nastaví vlastnost semaphores na hodnoty semaforů z items.

|#
;;;;;;;;;;;;;;;;;;;;;
;;;;;;SEMAPHORE;;;;;;
;;;;;;;;;;;;;;;;;;;;;

(defvar *variations*
  '(:pedestrian ((:red :green) ((t nil) (nil t)))
    :vehicle ((:red :yellow :green) ((t nil nil) (t t nil) (nil nil t) (nil t nil)))))

(defclass semaphore (picture)
  ((semaphore-type :initform :vehicle)
   (semaphore-phase :initform 0)
   (phase-count :initform 4)))

(defmethod semaphore-type ((sem semaphore))
  (slot-value sem 'semaphore-type))

(defmethod set-semaphore-type ((sem semaphore) type)
  (unless (symbolp type)
    (error "Type should be of type symbol."))
  (cond ((eql type :vehicle)
        (set-phase-count sem 4))
        ((eql type :pedestrian)
         (set-phase-count sem 2)))
  (setf (slot-value sem 'semaphore-type) type)
  (build-semaphore sem))

(defmethod semaphore-phase ((sem semaphore))
  (slot-value sem 'semaphore-phase))

(defmethod set-semaphore-phase ((sem semaphore) num)
  (unless (numberp num)
    (error "Phase should be a number"))
  (setf (slot-value sem 'semaphore-phase) num)
  (build-semaphore sem))

(defmethod phase-count ((sem semaphore))
  (slot-value sem 'phase-count))

(defmethod set-phase-count ((sem semaphore) num)
  (setf (slot-value sem 'phase-count) num))

(defmethod initialize-instance ((sem semaphore) &key)
  (call-next-method)
  (build-semaphore sem))

;;;;;Pomocné funkce pro tvorbu semaforu

(defun make-polygon (num)
  (let ((rect (make-instance 'polygon))
        (z (+ (* num 40) (* (+ num 1) 10) 20)))
    (set-filledp rect t)
    (set-items rect 
               (list (move (make-instance 'point) 20 20)
                     (move (make-instance 'point) 80 20)
                     (move (make-instance 'point) 80 z)
                     (move (make-instance 'point) 20 z)))))

(defun make-lights (lights-num)
  (let ((items '())
        (move-y 50)
        (light nil))
    (dotimes (x lights-num)
      (setf light (move (set-radius (make-instance 'light)
                                    20) 50 move-y))
      (setf move-y (+ move-y 50))
      (setf items (cons light items)))
    items))

(defun make-semaphore (lights-num colors)
  (let ((items '()))
    (setf items (make-lights lights-num))
    (mapcar (lambda (x y) (set-on-color y x)) colors items)
    (setf items (cons (make-polygon lights-num) items))
    (setf items (reverse items))))

;;;;;Vytvoří a vrátí obrázek semaforu

(defmethod build-semaphore ((sem semaphore))
  (let ((vehicle-colors '(:green :orange :red))
        (pedestrian-colors '(:green :red))
        (type (semaphore-type sem)))
    (cond ((eql type :vehicle)
           (set-items sem (make-semaphore 3 vehicle-colors))
           (vehicle-light-phases sem))
          ((eql type :pedestrian)
           (set-items sem (make-semaphore 2 pedestrian-colors))
           (pedestrian-light-phases sem)))))

(defmethod lights ((sem semaphore))
  (let* ((items (reverse (items sem)))
         (lights (cdr items)))
    lights))

(defmethod vehicle-light-phases ((sem semaphore))
  (let ((lights (lights sem)))
    (cond ((= (semaphore-phase sem) 0)
           (set-off (first lights))
           (set-off (second lights))
           (set-on (third lights))
           sem)
           ((= (semaphore-phase sem) 1)
            (set-off (first lights))
            (set-on (second lights))
            (set-on (third lights))
            sem)
           ((= (semaphore-phase sem) 2)
            (set-on (first lights))
            (set-off (second lights))
            (set-off (third lights))
            sem)
           ((= (semaphore-phase sem) 3)
            (set-off (first lights))
            (set-on (second lights))
            (set-off (third lights))
            sem))))

(defmethod pedestrian-light-phases ((sem semaphore))
  (let ((lights (lights sem)))
    (cond ((= (semaphore-phase sem) 0)
           (set-off (first lights))
           (set-on (second lights))
           sem)
           ((= (semaphore-phase sem) 1)
            (set-on (first lights))
            (set-off (second lights))
            sem))))

(defmethod next-phase ((sem semaphore))
  (if (= (semaphore-phase sem) (- (phase-count sem) 1))
      (set-semaphore-phase sem 0)
    (set-semaphore-phase sem (+ (semaphore-phase sem) 1)))
  sem)


#|(loop for x from 0 to 300 do
                   (next-phase sem)
                  (redraw w)
                  (sleep 0.3))
|#

;;;;;;;;;;;;;;;;;;;;;;
;;;;;;CROSSROADS;;;;;;
;;;;;;;;;;;;;;;;;;;;;;

(defclass crossroads (picture)
  ((semaphores :initform '())
   (crossroads-phase :initform 0)
   (phase-count :initform 0)
   (program :initform '())))

(defmethod semaphores ((cr crossroads))
  (slot-value cr 'semaphores))
            
(defmethod crossroads-phase ((cr crossroads))
  (slot-value cr 'crossroads-phase))

(defmethod set-crossroads-phase ((cr crossroads) value)
  (setf (slot-value cr 'crossroads-phase) value)
  (set-phases cr)
  cr)

(defmethod phase-count ((cr crossroads))
  (slot-value cr 'phase-count))

(defmethod set-phase-count ((cr crossroads) value)
  (setf (slot-value cr 'phase-count) value))

(defmethod program ((cr crossroads))
  (slot-value cr 'program))

(defmethod set-program ((cr crossroads) value)
  (unless (= (length (semaphores cr)) (length (car value)))
    (error "Number of semaphores in program does not fit the number of semaphores."))
  (setf (slot-value cr 'program) value)
  (set-phase-count cr (length value))
  (set-phases cr))

(defun return-list (phase list)
  (if (= phase 0)
      (car list)
    (return-list (- phase 1) (cdr list))))

(defmethod set-phases ((cr crossroads))
  (let ((phases (return-list (crossroads-phase cr) (program cr)))
        (sems (semaphores cr)))
    (mapcar (lambda (x y) (set-semaphore-phase x y)) sems phases)
    (move-semaphores cr)))
      
(defmethod read-semaphores ((cr crossroads))
  (let ((items (items cr))
        (semaphores '()))
    (dolist (item items)
      (when (typep item 'semaphore)
         (setf semaphores (cons item semaphores))))
    (setf (slot-value cr 'semaphores) semaphores)))

#|(defmethod move-semaphores ((cr crossroads))
  (let ((items (semaphores cr))
        (move-x 70))
    (dolist (sem (cdr items))
     (move sem move-x 0)
     (setf move-x (+ move-x 70)))
    cr))

|#

(defmethod move-semaphores ((cr crossroads))
  (let ((items (semaphores cr))
        (angle 90)
        (center (make-instance 'point)))
    (set-x center 10)
    (set-y center 100)
    (move (car items) 150 0)
    (dolist (sem (cdr items))
     (rotate sem angle center)
     (setf angle (+ angle 90))))
    cr)

(defmethod set-items ((cr crossroads) value)
  (call-next-method)
  (read-semaphores cr)
  (move-semaphores cr))

(defmethod next-phase ((cr crossroads))
  (if (= (crossroads-phase cr) (- (phase-count cr) 1))
      (set-crossroads-phase cr 0)
    (set-crossroads-phase cr (+ (crossroads-phase cr) 1)))
  cr)

(defvar semA (make-instance 'semaphore))
(defvar semB (make-instance 'semaphore))
(defvar semC (make-instance 'semaphore))
(defvar semD (make-instance 'semaphore))

(defun res ()
  (setf sem (make-instance 'semaphore))
  (move sem 100 50)
  (set-shape w sem)
  (redraw w))
