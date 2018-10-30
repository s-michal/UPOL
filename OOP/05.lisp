;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;
;;;; Zdrojový soubor k učebnímu textu M. Krupka: Objektové programování
;;;;
;;;; Kapitola 5, Dědičnost
;;;;

#| 
Před načtením souboru načtěte knihovnu micro-graphics
Pokud při načítání (kompilaci) dojde k chybě 
"Reader cannot find package MG",
znamená to, že knihovna micro-graphics není načtená.
|#

#|

DOKUMENTACE
-----------

TŘÍDA SHAPE
-----------

Potomky třídy shape jsou všechny třídy grafických objektů. Sama není určena k
vytváření přímých instancí.


NOVÉ VLASTNOSTI

window    Okno, ve kterém je objekt umístěn, nebo nil. Typicky ho instance 
          používají při kreslení. Nastavovat ho smí pouze nadřízené objekty
shape-mg-window 
          mg-window okna window.
color, thickness, filledp     
          Grafické parametry: barva, tloušťka pera, zda kreslit vyplněné.


NOVÉ ZPRÁVY

move object dx dy
rotate object angle center
scale object coeff center

Realizují geometrické transformace objektu object. Ve třídě shape nedělají 
nic. Potomci by je měli přepsat a příslušné transformace implementovat.

draw shape

Vykreslí shape do jejího okna. Typicky voláno nadřízeným objektem. Ve třídě 
shape zasílá zprávy set-mg-params a do-draw.

set-mg-params shape

Nastaví kreslicí parametry okna knihovny micro-graphics, ve kterém je objekt 
umístěn, tak, aby mohl být později vykreslen. Ve třídě shape nastavuje 
parametry :foreground, :filledp, :thickness podle hodnot vlastností color,
filledp a thickness (pořadě). Zasílá se z metody draw třídy shape. Není nutné
volat jindy. Potomci mohou přepsat.

do-draw shape

Vykreslí objekt shape do jeho okna. Může počítat s tím, že grafické parametry
okna knihovny micro-graphics jsou už nastaveny (metodou set-mg-params).
Zasílá se z metody draw třídy shape. Není nutné volat jindy. Potomci mohou 
přepsat. Ve třídě shape nedělá nic.


TŘÍDA POINT (SHAPE)
-------------------

Geometrický bod s kartézskými a polárními souřadnicemi. Kreslí se jako
vyplněné kolečko.


NOVÉ VLASTNOSTI

x, y, r, phi  Kartézské a polární souřadnice.

NOVÉ ZPRÁVY

set-r-phi point r phi

Souběžné nastavení obou polárních souřadnic.

PŘEPSANÉ METODY

move point dx dy
rotate point angle center
scale point coeff center

Implementují geometrické transformace bodu.

set-mg-params point

Modifikuje zděděnou metodu tak, že nastavuje :filledp na T.

do-draw point

Vykreslí bod jako vyplněné kolečko o poloměru rovném nastavené thickness.


TŘÍDA CIRCLE (SHAPE)
--------------------

Kolečka se středem (instance třídy point) a poloměrem. Středu lze nastavovat
souřadnice a aplikovat na něj transformace.

NOVÉ VLASTNOSTI

center   Střed. Instance třídy point. Jen ke čtení.
radius   Poloměr.


PŘEPSANÉ METODY

move circle dx dy
rotate circle angle center
scale circle coeff center

Implementují geometrické transformace kruhu.


TŘÍDA COMPOUND-SHAPE (SHAPE)
----------------------------

Předek tříd grafických objektů, složených z jiných grafických objektů.

NOVÉ VLASTNOSTI

items   Seznam podobjektů. Při nastavování otestuje validitu nastavovaných
        podobjektů (zprávou check-items) a uloží kopii seznamu. Při čtení 
        rovněž vrací kopii.


NOVÉ ZPRÁVY

check-item shape item

Otestuje, zda objekt item může být podobjektem složeného objektu shape. Pokud
ne, vyvolá chybu. Ve třídě compound-shape vyvolává chybu pořád, potomci metodu 
musí přepsat.

check-items shape items

Otestuje, zda seznam items může být seznamem podobjektů objektu shape. Pokud
ne, vyvolá chybu. Ve třídě compound-shape posílá zprávu check-item pro každý
prvek seznamu items.

set-items shape value

Nastaví kopii seznamu value jako vlastnost items složeného objektu shape.
Předtím seznam prověří zprávou check-items. Kromě vlastního nastavení vlastnosti 
items nastavuje všem objektům v seznamu vlastnost window na (window shape).

send-to-items shape message &rest arguments

Lze použít, pokud chceme všem podobjektům složeného objektu shape poslat
tutéž zprávu se stejnými argumenty. Klíčové slovo &rest zatím není nutné
přesně chápat. Umožňuje předání libovolného počtu argumentů.


PŘEPSANÉ METODY

move shape dx dy
rotate shape angle center
scale shape coeff center

Pomocí zprávy send-to-items přepošle zprávu move (nebo rotate, nebo scale) 
všem podobjektům.


TŘÍDA PICTURE (COMPOUND-SHAPE)
------------------------------

Složený grafický objekt, který se vykresluje tak, že postupně vykreslí všechny
podobjekty.


PŘEPSANÉ VLASTNOSTI

window   Při nastavování automaticky nastaví totéž okno i všem podobjektům


PŘEPSANÉ METODY

check-item picture item

Vyvolá chybu, pokud item není typu shape.

do-draw picture

Pošle zprávu draw všem podobjektům (v opačném pořadí, aby se vykreslily zezadu
dopředu)


TŘÍDA POLYGON (COMPOUND-SHAPE)
------------------------------

Grafický objekt složený z bodů. Vykresluje se jako polygon. Proti 
compound-shape má novou vlastnost: closedp.

NOVÉ VLASTNOSTI

closedp  Při filledp nastaveném na false určuje, zda do polygonu patří i
         úsečka spojující první a poslední bod.


PŘEPSANÉ METODY

check-item polygon item

Vyvolá chybu, pokud item není bod.

set-mg-params polygon

Volá zděděnou metodu a pak nastavuje kreslicí parametr closedp.

do-draw polygon

Vykreslí polygon zavoláním mg:draw-polygon.


TŘÍDA WINDOW (MG-OBJECT)
------------------------

Instance reprezentují okna knihovny micro-graphics. Okno se otevře automaticky
při vytváření nové instance. Oknu lze nastavit barvu pozadí a vykreslovaný
grafický objekt.


NOVÉ VLASTNOSTI

shape      Grafický objekt vykreslovaný do okna.
background Barva pozadí okna.
mg-window  Odkaz na okno knihovny micro-graphics. Jen ke čtení.


NOVÉ ZPRÁVY

redraw window

Vymaže okno barvou pozadí (vlastnost background) a pak vykreslí do okna objekt
uložený ve vlastnosti shape tím, že mu pošle zprávu draw. Nevolat přímo, 
používat zprávu invalidate.

|#


;;;
;;; Třída shape
;;;

(defclass shape ()
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

(defmethod set-color ((shape shape) value) 
  (setf (slot-value shape 'color) value)
  shape)

(defmethod thickness ((shape shape)) 
  (slot-value shape 'thickness)) 

(defmethod set-thickness ((shape shape) value) 
  (setf (slot-value shape 'thickness) value)
  shape) 

(defmethod filledp ((shape shape))
  (slot-value shape 'filledp))

(defmethod set-filledp ((shape shape) value)
  (setf (slot-value shape 'filledp) value)
  shape)

(defmethod move ((shape shape) dx dy)
  shape)

(defmethod rotate ((shape shape) angle center)
  shape)

(defmethod scale ((shape shape) coeff center)
  shape)

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

(defmethod set-x ((point point) value)
  (unless (typep value 'number)
    (error "x coordinate of a point should be a number"))
  (setf (slot-value point 'x) value)
  point)

(defmethod set-y ((point point) value)
  (unless (typep value 'number)
    (error "y coordinate of a point should be a number"))
  (setf (slot-value point 'y) value)
  point)

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

(defmethod move ((pt point) dx dy)
  (set-x pt (+ (x pt) dx))
  (set-y pt (+ (y pt) dy))
  pt)

(defmethod rotate ((pt point) angle center)
  (let ((cx (x center))
        (cy (y center)))
    (move pt (- cx) (- cy))
    (set-phi pt (+ (phi pt) angle))
    (move pt cx cy)
    pt))

(defmethod scale ((pt point) coeff center)
  (let ((cx (x center))
        (cy (y center)))
    (move pt (- cx) (- cy))
    (set-r pt (* (r pt) coeff))
    (move pt cx cy)
    pt))


;;;
;;; Třída circle
;;;

(defclass circle (shape) 
  ((center :initform (make-instance 'point)) 
   (radius :initform 1)))

(defmethod radius ((c circle))
  (slot-value c 'radius))

(defmethod set-radius ((c circle) value)
  (when (< value 0)
    (error "Circle radius should be a non-negative number"))
  (setf (slot-value c 'radius) value)
  c)

(defmethod center ((c circle))
  (slot-value c 'center))

(defmethod do-draw ((c circle))
  (mg:draw-circle (shape-mg-window c)
                  (x (center c))
                  (y (center c))
                  (radius c))
  c)

(defmethod move ((c circle) dx dy)
  (move (center c) dx dy)
  c)

(defmethod rotate ((c circle) angle center)
  (rotate (center c) angle center)
  c)

(defmethod scale ((c circle) coeff center)
  (scale (center c) coeff center)
  (set-radius c (* (radius c) coeff))
  c)


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

(defmethod set-items ((shape compound-shape) value)
  (check-items shape value)
  (setf (slot-value shape 'items) (copy-list value))
  shape)

(defmethod move ((shape compound-shape) dx dy)
  (send-to-items shape 'move dx dy)
  shape)

(defmethod rotate ((shape compound-shape) angle center)
  (send-to-items shape 'rotate angle center)
  shape)

(defmethod scale ((shape compound-shape) coeff center)
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

(defmethod set-items ((pic picture) items)
  (call-next-method)
  (send-to-items pic 'set-window (window pic)))

(defmethod draw ((pic picture))
  (dolist (item (reverse (items pic)))
    (draw item))
  pic)

(defmethod set-window ((shape picture) value)
  (send-to-items shape 'set-window value)
  (call-next-method))


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

(defmethod set-closedp ((p polygon) value)
  (setf (slot-value p 'closedp) value)
  p)

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


;;;
;;; Třída window
;;;

(defclass window ()
  ((mg-window :initform (mg:display-window))
   (shape :initform nil)
   (background :initform :white)))

(defmethod mg-window ((window window))
  (slot-value window 'mg-window))

(defmethod shape ((w window))
  (slot-value w 'shape))

(defmethod set-shape ((w window) shape)
  (when shape
    (set-window shape w))
  (setf (slot-value w 'shape) shape)
  w)

(defmethod background ((w window))
  (slot-value w 'background))

(defmethod set-background ((w window) color)
  (setf (slot-value w 'background) color)
  w)

(defmethod redraw ((window window))
  (let ((mgw (mg-window window)))
    (mg:set-param mgw :background (background window))
    (mg:clear mgw)
    (when (shape window)
      (draw (shape window))))
  window)



