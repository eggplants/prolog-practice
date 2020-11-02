%
% hanoi2.pl - ハノイの搭 (試行錯誤法)
%

% Step4まで(堂々巡りする)

% 最終的な目的状態
pole([], [], [_| _]).

% 1番目の棒から3番目の棒へ移動
pole([A| AL], B, []) :-
    pole(AL, B, [A]),
    writeln(pole(AL, B, [A])).
pole([A| AL], B, [C| CL]) :-
    A < C, pole(AL, B, [A, C| CL]),
    writeln(pole(AL, B, [A, C| CL])).

% 1番目の棒から2番目の棒へ移動
pole([A| AL], [], C) :-
    pole(AL, [A], C),
    writeln(pole(AL, [A], C)).
pole([A| AL], [B| BL], C) :-
    A < B, pole(AL, [A, B| BL], C),
    writeln(pole(AL, [A, B| BL], C)).

% 2番目の棒から1番目の棒へ移動
pole([], [B| BL], C) :-
    pole([B], BL, C),
    writeln(pole([B], BL, C)).
pole([A| AL], [B| BL], C) :-
    B < A, pole([B, A| AL], BL, C),
    writeln(pole([B, A| AL], BL, C)).

% 2番目の棒から3番目の棒へ移動
pole(A, [B| BL], []) :-
    pole(A, BL, [B]),
    writeln(pole(A, BL, [B])).
pole(A, [B| BL], [C| CL]) :-
    B < C, pole(A, BL, [B, C| CL]),
    writeln(pole(A, BL, [B, C| CL])).

% 3番目の棒から1番目の棒へ移動
pole([], B, [C| CL]) :-
    pole([C], B, CL),
    writeln(pole([C], B, CL)).
pole([A| AL], B, [C| CL]) :-
    C < A, pole([C, A| AL], B, CL),
    writeln(pole([C, A| AL], B, CL)).

% 3番目の棒から2番目の棒へ移動
pole(A, [], [C| CL]) :-
    pole(A, [C], CL),
    writeln(pole(A, [C], CL)).
pole(A, [B| BL], [C| CL]) :-
    C < B, pole(A, [C, B| BL], CL),
    writeln(pole(A, [C, B| BL], CL)).

