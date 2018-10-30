;1
;Naprogramujte rekurzivní proceduru IT, která pro danou velikost n term list vrátí
;(it 3 'a list) -> (a (a) ((a)))
;(it 0 'a list) -> ()

(define it
  (lambda (n term f)
    (if (= n 0)
        '()
        (cons term (it (- n 1) (f term) f)))))

(it 3 'a list)

;2
;Naprogramujte iterativní proceduru REVJOIN, která pro argumenty n l
;otočí n prvků v seznamu, bez použití reverse a apply
;(revjoin 4 '(1 2 3 4 5 6)) - > (4 3 2 1 5 6)

(define revjoin
  (lambda (n l)
    (let iter ((l l)
               (i n)
               (accum '()))
      (if (= i 0) 
          (append accum l)
          (iter (cdr l) (- i 1) (cons (car l) accum))))))

(revjoin 4 '(1 2 3 4 5 6))

;3
;Napište na co se následující výraz vyhodnotí a zakreslete hierarchii prostředí

(map (let* ((x (list))
            (y (list x)))
       (lambda (x) (x y)))
     (list car cdr))

;4
;Napiště výraz, jehož vyhodnocením vznikne následující interní reprezentace
;výraz výjádřete i v jeho externí reprezentaci

(let* ((a (cons 1 2)))
  (cons (cons a 3) (cons a '())))

;5
;vysvětlení pojmů: 
;lambda výraz
;garbage collector
;hloubková rekurze
;currying
;dynamický rozsah platnosti


;6
;zjistěte co následující procedura dělá, jaké ma vstupní argumenty, otestujte 2
;netriviální vstupy a přepiště proceduru bez and or a kvazikvótování

(define proc
  (lambda (x . y)
    (or (and (null? x )y)
        (apply proc (cdr x)
               `(,(car x) ,@y)))))

(proc '(1 2 3) 4 5 6)


(define procy
  (lambda (x . y)
    (let z ((x x)
          (y y))
      (if (null? x)
          y
          (z (cdr x)
             (cons (car x) y))))))

(procy '(1 2 3) 4 5 6)