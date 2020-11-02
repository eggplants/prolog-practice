%
% hanoi3.pl - ハノイの搭 (試行錯誤法)
%

% Step5まで(深さ制限をつけたもの)
% 第4引数が深さの上限を示す

% 最終的な目的状態
pole([], [], [_| _], _).

% 1番目の棒から3番目の棒へ移動
pole([A| AL], B, [], N) :-
    N > 0, N1 is N - 1,
    pole(AL, B, [A], N1),
    writeln(pole(AL, B, [A])).
pole([A| AL], B, [C| CL], N) :-
    N > 0, N1 is N - 1,
    A < C, pole(AL, B, [A, C| CL], N1),
    writeln(pole(AL, B, [A, C| CL])).

% 1番目の棒から2番目の棒へ移動
pole([A| AL], [], C, N) :-
    N > 0, N1 is N - 1,
    pole(AL, [A], C, N1),
    writeln(pole(AL, [A], C)).
pole([A| AL], [B| BL], C, N) :-
    N > 0, N1 is N - 1,
    A < B, pole(AL, [A, B| BL], C, N1),
    writeln(pole(AL, [A, B| BL], C)).

% 2番目の棒から1番目の棒へ移動
pole([], [B| BL], C, N) :-
    N > 0, N1 is N - 1,
    pole([B], BL, C, N1),
    writeln(pole([B], BL, C)).
pole([A| AL], [B| BL], C, N) :-
    N > 0, N1 is N - 1,
    B < A, pole([B, A| AL], BL, C, N1),
    writeln(pole([B, A| AL], BL, C)).

% 2番目の棒から3番目の棒へ移動
pole(A, [B| BL], [], N) :-
    N > 0, N1 is N - 1,
    pole(A, BL, [B], N1),
    writeln(pole(A, BL, [B])).
pole(A, [B| BL], [C| CL], N) :-
    N > 0, N1 is N - 1,
    B < C, pole(A, BL, [B, C| CL], N1),
    writeln(pole(A, BL, [B, C| CL])).

% 3番目の棒から1番目の棒へ移動
pole([], B, [C| CL], N) :-
    N > 0, N1 is N - 1,
    pole([C], B, CL, N1),
    writeln(pole([C], B, CL)).
pole([A| AL], B, [C| CL], N) :-
    N > 0, N1 is N - 1,
    C < A, pole([C, A| AL], B, CL, N1),
    writeln(pole([C, A| AL], B, CL)).

% 3番目の棒から2番目の棒へ移動
pole(A, [], [C| CL], N) :-
    N > 0, N1 is N - 1,
    pole(A, [C], CL, N1),
    writeln(pole(A, [C], CL)).
pole(A, [B| BL], [C| CL], N) :-
    N > 0, N1 is N - 1,
    C < B, pole(A, [C, B| BL], CL, N1),
    writeln(pole(A, [C, B| BL], CL)).

