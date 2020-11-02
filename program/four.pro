% 四色問題

% map(Place_1, ..., Place_n)で実行
% それぞれに塗る色が探索されて入力

% 接する
nearby(X, Y) :- by(X, Y).
nearby(X, Y) :- by(Y, X).

% 色は隣り合わないというルール
by(yellow, blue). by(blue, red). by(red, orange).
by(orange, yellow). by(yellow, red). by(blue, orange).

% 地図データ
map(A, B, C, D, E, F, G, H, I, J) :-
    by(A, B), by(A, F), by(A, G),
    by(B, C), by(B, D), by(B, F), by(B, G),
    by(C, D), by(C, I), by(C, J),
    by(D, G), by(D, H), by(D, J),
    by(E, F),
    by(G, H),
    by(I, J). 
