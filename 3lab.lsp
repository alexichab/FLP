; Вариант 2

; 1. Является ли одно множество подмножеством другого.
(defun is-subset (a b) (cond ((null a) t) ((member (car a) b) (is-subset (cdr a) b)) (t nil)))  

(print (is-subset '(x y) '(a c v x z y)))
(print (is-subset '(x y) '(a c v z y)))



; 2. Возвращающую объединение двух множеств.
;(defun in? (a l) (cond ((null l) nil) ((eq a (car l)) t) (t (in? a (cdr l))))) 
(defun AandB (a b) (cond ((null a) b) ((null b) a) ((member (car a) b) (AandB (cdr a) b) ) (t (cons (car a) (AandB (cdr a) b))))) 

(print (AandB '(a b 1 c) '(b 2 (3) c d)))

; 3. Заменяющий все элементы списка, не обладающие определенным свойством, на символ
;    *. Проверьте работу функционала для предикатов:
;    - число (функциональный аргумент – имя встроенного предиката numberp);
;    - отрицательное число (функциональный аргумент – лямбда выражение).
(defun chng* (func lst) (cond ((null lst) nil) ((funcall func (car lst)) (cons '* (chng* func (cdr lst)))) (t (cons (car lst) (chng* func (cdr lst))))))
 
(print (chng* #'numberp '(1 2 3 A 5 6)))
(print (chng* #'(lambda (x) (< x 0)) '(-1 2 3 -6 -7 -7)))