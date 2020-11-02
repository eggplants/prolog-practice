%
% 8-puzzle solver
% unify to [1, 2, 3, ..., 7, 8, 0]
%

target([1,2,3,4,5,6,7,8,0]). % aim to move panels

top(1). top(2). top(3).          % places
left(1). left(4). left(7).       % |1|2|3| 
right(3). right(6). right(9).    % |4|5|6|
bottom(7). bottom(8). bottom(9). % |7|8|9|

% check if enable to move from X to Y
movable(X, Y) :-
    (   not(right(X)), Y is X + 1   % move right
    ;   not(left(X)), Y is X - 1    % move left
    ;   not(top(X)), Y is X - 3     % move up
    ;   not(bottom(X)), Y is X + 3  % move down
    ).

% replace I-th of list L into A
% substitute:
%     B :- (prev. A)
%     R :- (replaced L)
replace(1, [B| L], A, [A| L], B).
replace(I, [X| L], A, [X| R], B) :-
    I > 1,
    I1 is I - 1,
    replace(I1, L, A, R, B).

% swap I-th of list L for J-th of list L
% substitute:
%     R :- (swapped L)
swap(L, I, I, L) :- !.
swap(L, I, J, R) :-
    I > J,
    swap(L, J, I, R), !.
swap([A| L], 1, J, [B| R]) :-
    J1 is J - 1,
    replace(J1, L, A, R, B), !.
swap([A| L], I, J, [A| R]) :-
    I1 is I - 1,
    J1 is J - 1,
    swap(L, I1, J1, R).

% generate number 0 to D
% and each number substitute into N
gennum(0, _).
gennum(N, D) :-
    D > 0, 
    D1 is D - 1,
    gennum(N1, D1),
    N is N1 + 1.

/*
    solve(盤面, MaxDepth, Cnt) :-
        深さ制限条件,
        値0の升の場所の特定,
        移動先の選定,
        升を入れ替えて次の盤面を得る,
        堂々巡り禁止条件,
        述語名(次の盤面, MaxDepth - 1, Cnt + 1),
        画面表示.
*/

% main func of solver
solve([A, B, C, D, E, F, G, H, I]) :-