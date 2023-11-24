% Предикат для создания начального списка
create_list(N, List) :- findall(Num, between(1, N, Num), List).

% Предикат для выполнения алгоритма Иосифа Флавия
josephus(N, M, Order) :-
    create_list(N, List),
    josephus_step(List, M, Order).

% Шаг алгоритма Иосифа Флавия
josephus_step(List, M, Order) :-
    josephus_cycle(List, M, 0, [], RevOrder),
    reverse(RevOrder, Order).

josephus_cycle([], _, _, Acc, Acc).
josephus_cycle(List, M, Start, Acc, Order) :-
    length(List, Len),
    Pos is (Start + M - 1) mod Len,
    nth0(Pos, List, Removed, Rest),
    josephus_cycle(Rest, M, Pos, [Removed|Acc], Order).

% Пример использования: josephus(7, 3, Order).