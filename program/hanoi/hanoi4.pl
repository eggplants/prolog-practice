%
% hanoi4.pl - 第4回 Step 5 まで - 深さ制限のみ
%

num3(N) :- member(N, [1, 2, 3]).

direction(I, J, K) :-
    num3(I),
    num3(J), J \= I,
    num3(K), K \= I, K \= J.

move([A| AL], [], AL, [A]).
move([A| AL], [B| BL], AL, [A, B| BL]) :- A < B.

pole([[], [], [_| _]], _).
pole(L, N) :- N > 0, N1 is N - 1,
    direction(I, J, K), nth1(I, L, A), nth1(J, L, B), nth1(K, L, C),
    move(A, B, A1, B1),
    L1 = [_, _, _], nth1(I, L1, A1), nth1(J, L1, B1), nth1(K, L1, C),
    pole(L1, N1),
    writeln(pole(L1)).

% ex. ?- pole([[1, 2, 3], [], []], 20).
