%
% hanoi0.pl - ハノイ（配付資料のまま)
%

% 円盤を1枚移動させる
move(N, A, C) :- writeln(move(N, from, A, to, C)).

% 複数枚の円盤を移動させる
hanoi(1, A, C, _) :- move(1, A, C).
hanoi(N, A, C, B) :-
    N1 is N - 1,
    hanoi(N1, A, B, C),
    move(N, A, C),
    hanoi(N1, B, C, A).

