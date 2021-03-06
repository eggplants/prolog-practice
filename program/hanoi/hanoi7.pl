%
% hanoi7.pl - 第4回 Step 5 まで - 堂々巡り禁止(全履歴) + 回数
% 反覆深化法により最短手順を求める。
/* 反復深化深さ優先探索(IDDFS)
function IDDFS(node)
    for (depth = 0; ; depth++)
        found = DLS(node, depth)
        if (found != NULL) then
            return found

function DLS(node, depth)
    if (IS_GOAL(node)) then
        return node
    if (depth > 0) then
        for each (child in EXPAND(node))
            found = DLS(child, depth - 1)
            if (found != NULL) then
                return found
    return NULL
*/

num3(N) :- member(N, [1, 2, 3]).

direction(I, J, K) :-
    num3(I),
    num3(J), J \= I,
    num3(K), K \= I, K \= J.

move([A| AL], [], AL, [A]).
move([A| AL], [B| BL], AL, [A, B| BL]) :- A < B.

pole([[], [], [_| _]], _, _, 0).
pole(L, N, H, M) :- N > 0, N1 is N - 1,
    direction(I, J, K), nth1(I, L, A), nth1(J, L, B), nth1(K, L, C),
    move(A, B, A1, B1),
    L1 = [_, _, _], nth1(I, L1, A1), nth1(J, L1, B1), nth1(K, L1, C),
    not(member(L1, H)),
    pole(L1, N1, [L1| H], M1),
    M is M1 + 1,
    writeln(pole(L1)).

% ex. ?- pole([[1, 2, 3], [], []], 20, [], X).

% 反覆深化法

try_hanoi(L, Max, Count) :-
    gennum4(N, Max),
    writeln(N),
    pole(L, N, [], Count).

% ex. ?- try_hanoi([[1, 2, 3], [], []], 20, C).
% 3 disks are located in left pole.

% generate number 0 to D
% and each number substitute into N
gennum4(0, _).
gennum4(N, D) :-
    D > 0,
    D1 is D - 1,
    gennum4(N1, D1),
    N is N1 + 1.