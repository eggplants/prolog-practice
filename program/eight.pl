%
% 8-puzzle solver
% unify to [1, 2, 3, ..., 7, 8, 0]
%

% 盤面定義
top(1). top(2). top(3).
left(1). left(4). left(7).
right(3). right(6). right(9).
bottom(7). bottom(8). bottom(9).

% 移動可能か見る
movable(I, J) :- not(right(I)), J is I + 1.
movable(I, J) :- not(left(I)), J is I - 1.
movable(I, J) :- not(top(I)), J is I - 3.
movable(I, J) :- not(bottom(I)), J is I + 3.

% コマの入れ替え
replace(1, [B| L], A, [A| L], B).
replace(I, [X| L], A, [X| R], B) :-
    I > 1,
    I1 is I - 1,
    replace(I1, L, A, R, B).

swap(L, I, I, L) :- !.
swap(L, I, J, R) :-
    I > J, swap(L, J, I, R), !.
swap([A| L], 1, J, [B| R]) :-
    J1 is J - 1, replace(J1, L, A, R, B), !.
swap([A| L], I, J, [A| R]) :-
    I1 is I - 1, J1 is J - 1,
    swap(L, I1, J1, R).

% 解けるか判定
abs2(X,Y) :- Y is abs(X). % 絶対値
parity(_, _, [], 0).
parity(L, Goal, [S|Ss], Parity) :-
    nth1(N, L, S), nth1(M, Goal, S),
    abs2(N - M, Dist),
    parity(L, Goal, Ss, NxtParity),
    Parity is NxtParity + Dist.


% 解く
iddfs([1, 2, 3, 4, 5, 6, 7, 8, 0], _, _, 0).
iddfs(Board, Dep, PreBoard, Count) :-
    Dep > 0, NxtDep is Dep - 1, % 深さ禁止条件
    nth1(Idx, Board, 0), % 値0の升の場所の特定
    movable(Idx, NxtIdx), Idx \= NxtIdx, % 移動先の選定
    swap(Board, Idx, NxtIdx, NxtBoard), % 升を入れ替えて次の盤面を得る
    NxtBoard \= PreBoard, % 堂々巡り禁止条件
    iddfs(NxtBoard, NxtDep, Board, NxtCount), % 再帰
    Count is NxtCount + 1,
    writeln(iddfs(NxtBoard)).
