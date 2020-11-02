%
% hanoi1.pl - ハノイ（円盤を動かす回数を数える)
%

% 円盤を1枚移動させる
move(N, A, C) :- writeln(move(N, from, A, to, C)).

% 複数枚の円盤を移動させる
hanoi1(1, A, C, _, 1) :- move(1, A, C).
% halt if reached goal
hanoi1(N, _, _, _, Z) :-
    Z is 2 ^ N - 1, !.
hanoi1(N, A, C, B, Z) :-
    N1 is N - 1,
    hanoi1(N1, A, B, C, X),
    move(N, A, C),
    hanoi1(N1, B, C, A, Y),
    Z is X + 1 + Y.

