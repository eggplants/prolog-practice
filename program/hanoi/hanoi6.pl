%
% hanoi6.pl - 第4回 Step 5 まで - 堂々巡り禁止(直前のパターンのみ)
%

num3(N) :- member(N, [1, 2, 3]).

direction(I, J, K) :-
    num3(I),
    num3(J), J \= I,
    num3(K), K \= I, K \= J.

move([A| AL], [], AL, [A]).
move([A| AL], [B| BL], AL, [A, B| BL]) :- A < B.

pole([[], [], [_| _]], _, _).
pole(L, N, H) :- N > 0, N1 is N - 1,
    direction(I, J, K), nth1(I, L, A), nth1(J, L, B), nth1(K, L, C),
    move(A, B, A1, B1),
    L1 = [_, _, _], nth1(I, L1, A1), nth1(J, L1, B1), nth1(K, L1, C),
    L1 \= H,
    pole(L1, N1, L),
    writeln(pole(L1)).

% ex. ?- pole([[1, 2, 3], [], []], 20, []).
% hanoi4.pl の結果と比較してみよ。
