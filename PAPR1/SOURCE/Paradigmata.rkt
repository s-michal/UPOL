;1) Doplňte něco, aby to vyšlo

((lambda x1 (+ 1 (- x))) + 5) ;6
(+ 10 (x2 5 10 15)) ;15
((x3 -) 10) ; -10
(x4 (lambda (x) (* x 2))) ;80
((((lambda (f) x5) *))) ;1

;2) Vykreslete hiearchii prostředí a nepiště výsledek
((lambda (x y)
   (y 20))
 1000
 ((lambda (x)
    (lambda (y)
      (- x y)))
  500))

;3) Nakreslit prostředí tak, aby sedělo pořadí prostředí. Na fotce na fb


;4) Na co se vyhodnotí? Pokud chyba tak proč?
(lambda () #f)
(not 0)
(or not)
(and (and))
;(* 2 3 - 4) ;chyba
((lambda (x) (lambda (y) x)) 1)
(and (<= 3 2) (3 <= 2)) ;je dobře, nevím proč
;10++ ;chyba 
(/ 1 2 3)
(/ (/ (- (- 1))))
(if #t #f #t)
(if 10 (/ 20) (/))
(((lambda (x y) x) * +))
((if (or) - /) 10 20)
(cond (not #f) (else 30))
(cond ((not #f) 30))
;(cond ((not #f) (else 30)))