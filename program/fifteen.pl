%
% 15-puzzle solver
% unify to [1, 2, 3, ..., 13, 14, 15, 0]
% Impl.: IDDFS + IDA*
% TODO: Hash + IDA*
% MEMO :-
%   15パズルの盤面に左上から右下まで1,...,16をふる,
%   L is 現在の盤上の数字(0~15,0は空きマス)を順に入れたlist,
%   R is 目標の盤面[*1..15,0]のlist,
%   マンハッタン距離(L, R, H),
%   Cnt+H>Depthで枝狩り,
%   偶置換でだめ,
%   目標A(a_x, a_y), 現在B(b_x, b_y),
%   H=Σ{abs(a_x-b_x)+abs(a_y-b_y)}.
%

% 盤面定義
top(1). top(2). top(3). top(4).
left(1). left(5). left(9). left(13).
right(4). right(8). right(12). right(16).
bottom(13). bottom(14). bottom(15). bottom(16).

% 移動可能か見る
movable(I, J) :- not(right(I)), J is I + 1.
movable(I, J) :- not(left(I)), J is I - 1.
movable(I, J) :- not(top(I)), J is I - 4.
movable(I, J) :- not(bottom(I)), J is I + 4.

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

% マンハッタン距離
parity(_, _, [], 0).
parity(L, Goal, [S|Ss], Parity) :-
    nth0(N, L, S),
    NX is N mod 4,
    NY is N // 4,
    nth0(M, Goal, S),
    MX is M mod 4,
    MY is M // 4,
    Dist is abs(NX - MX) + abs(NY - MY),
    parity(L, Goal, Ss, NxtParity),
    Parity is NxtParity + Dist.


% 解く
ida(L, _, _, _, Goal, 0) :- L = Goal.
ida(Board, MaxDep, Dep, PreBoard, Goal, Count) :-
    Dep > 0, NxtDep is Dep - 1,               % 深さ禁止条件
    nth1(Idx, Board, 0),                      % 値0の升の場所の特定
    movable(Idx, NxtIdx), Idx \= NxtIdx,      % 移動先の選定
    swap(Board, Idx, NxtIdx, NxtBoard),       % 升を入れ替えて次の盤面を得る
    parity(NxtBoard, Goal, Goal, H),          % マンハッタン距離
    H + MaxDep-Dep =< Dep,                    % 枝狩り
    NxtBoard \= PreBoard,                     % 戻る手を禁止
    ida(NxtBoard, MaxDep, NxtDep, Board, Goal, NxtCount),!, % 再帰
    Count is NxtCount + 1,
    writeln(iddfs(NxtBoard)).

solve(L, Dep, Count) :-
    Goal = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0],
    ida(L, Dep, Dep, [], Goal, Count).

gennum(0, _).
gennum(N, D) :-
    D > 0, D1 is D - 1,
    gennum(N1, D1),
    N is N1 + 2.

try_solve(L, Max, Count) :-
    Goal = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 0],
    parity(L, Goal, Goal, Parity),
    % mod(Parity, 2) \= 0,
    gennum(N, Max),
    % writeln(Parity),
    N > Parity,
    % writeln(N),
    solve(L, N, Count).

test(1, A) :-
    time(try_solve([1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 11, 12, 13, 14, 15, 10], 50, A)).
test(2, B) :-
    time(try_solve([1, 2, 3, 0, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 4], 50, B)).
test(3, C) :-
    time(try_solve([1, 0, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 2], 50, C)).

