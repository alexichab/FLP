%1.
print_odd_descending :- 
    write('Введите нижнюю границу: '), 
    read(Low),
    write('Введите верхнюю границу: '), 
    read(High),
    print_odd_descending(High, Low).

% Рекурсивный предикат для печати нечетных чисел в порядке убывания
print_odd_descending(High, Low) :- 
    High >= Low,
    (   0 is High mod 2 -> NewHigh is High - 1; NewHigh is High ),
    write(NewHigh), nl,
    Next is NewHigh - 2,
    print_odd_descending(Next, Low).
print_odd_descending(High, Low) :- 
    High < Low.

%2. Написать предикат, который находит числа Фибоначчи по их номерам, которые в цикле
%   вводятся с клавиатуры. Запрос номера и нахождение соответствующего числа Фибоначчи
%   должно осуществляться до тех пор, пока не будет введено отрицательное число.
%   Циклический ввод организовать с помощью предиката repeat. Числа Фибоначчи определяются
%   по следующим формулам:
%   F(0)=1, F(1)=1, F(i)=F(i-2)+F(i-1) (i=2, 3, 4, ...).
calc_fibonacci(0, Y) :- Y is 1, !.
calc_fibonacci(1, Y) :- Y is 1, !.

calc_fibonacci(X, Y) :-
	X1 is X - 2,
	X2 is X - 1,
	calc_fibonacci(X1, Y1),
	calc_fibonacci(X2, Y2),
	Y is Y1 + Y2.

fibonacci() :-
	repeat,
	read(X),
	(X < 0, !; calc_fibonacci(X, Y), write(Y), nl, fail).


% 3. Написать предикат, который разбивает числоваой список по двум числам, вводимым 
%    с клавиатуры на три списка: меньше введенного числа, от меньшего введенного 
%    числа до большего введенного числа, больше большего введенного числа.
%    Список и два числа вводятся с клавиатуры в процессе работы предиката.

	splite :-
		read(List),read(A),read(B),splite_prepare(A, B, Min, Max),
		splite_rec(List, Min, Max, List1, List2, List3),
		write(List1), write(List2), writeln(List3).

	splite_prepare(A, B, Min, Max) :- A > B, !, Max = A, Min = B; Max = B, Min = A.

	splite_rec([], _A, _B, [], [], []).
       
	splite_rec([Head|Tail], A, B, [Head|List1], List2, List3) :-
		Head < A, !,splite_rec(Tail, A, B, List1, List2, List3).
	splite_rec([Head|Tail], A, B, List1, [Head|List2], List3) :-
		Head =< B, !, splite_rec(Tail, A, B, List1, List2, List3).
	splite_rec([Head|Tail], A, B, List1, List2, [Head|List3]) :-
		!, splite_rec(Tail, A, B, List1, List2, List3).

% 4. Написать предикат, который формирует список из наиболее часто встречающихся 
%    элементов списка. Список вводится с клавиатуры в процессе работы предиката.

	f :-
		read(List), msort(List, SList), cou(SList, _, ResList), write(ResList).

	cou([], 0, []).
	cou([H|B], K, [H]) :-
		foo([H|B], H, K, List), cou(List, MX, _), K > MX, !.
	cou([H|B], MX, List1) :-
		foo([H|B], H, K, List), cou(List, MX, List1), K < MX, !.
	cou([H|B], MX, [H|List1]) :-
		foo([H|B], H, K, List), cou(List, MX, List1), K =:= MX, !.

	foo([], _, 0, []) :- !.
	foo([H|B], X, 0, [H|B]) :- H =\= X, !.
	foo([H|B], X, K, B1) :-  H =:= X,  foo(B, X, K1, B1), K is K1 + 1.
	
	
% Основной предикат
frequent_elements :-
    read(List),
    count_elements(List, CountList),
    find_max_frequency(CountList, MaxFreq),
    extract_elements_with_frequency(CountList, MaxFreq, Result),
    write(Result).

% Подсчет количества вхождений каждого элемента
count_elements([], []).
count_elements([H|T], [[H,Count]|RestCountList]) :-
    count_element(H, T, RestT, Count1),
    Count is Count1 + 1,
    count_elements(RestT, RestCountList).

count_element(_, [], [], 0).
count_element(E, [H|T], [H|RestT], Count) :-
    E \= H,
    count_element(E, T, RestT, Count).
count_element(E, [E|T], RestT, Count) :-
    count_element(E, T, RestT, Count1),
    Count is Count1 + 1.

% Нахождение максимальной частоты
find_max_frequency([], 0).
find_max_frequency([[_, Freq]|T], MaxFreq) :-
    find_max_frequency(T, MaxT),
    MaxFreq is max(Freq, MaxT).

% Извлечение элементов с максимальной частотой
extract_elements_with_frequency([], _, []).
extract_elements_with_frequency([[E, Freq]|T], MaxFreq, [E|RestResult]) :-
    Freq =:= MaxFreq,
    extract_elements_with_frequency(T, MaxFreq, RestResult).
extract_elements_with_frequency([[_, Freq]|T], MaxFreq, Result) :-
    Freq \= MaxFreq,
    extract_elements_with_frequency(T, MaxFreq, Result).
