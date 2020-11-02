% 練習1: brother/2

parent(taro, hanako).
parent(hanako, jiro).
parent(taro, saburo).
parent(hanako, shiro).
parent(saburo, ishiro).
parent(shiro, goro).

brother(X, Y) :-
    parent(A, X),
    parent(B, Y),
    A = B,
    X \= Y.

% 練習2: ancestor/2

ancestor(X, Y) :-
    parent(X, Y).
ancestor(X, Z) :-
    parent(X, Y),
    parent(Y, Z).

% 練習3: first/2, second/2, third/2

first(A, [A | _]).
second(A, [_, A | _]).
third(A, [_, _, A| _]).

% 練習4: my_member/2

my_member(A, [A | _]).
my_member(A, [_ | B]) :-
    my_member(A, B).

% 練習5-1:

/*
X = 1 + 2.   % X = 1+2
X is 1 + 2.  % X = 3.
3 = 1 + 2.   % false.
3 is 1 + 2.  % true.
*/

% 練習5-2: my_length/2

my_length([], 0).
my_length([_|A], LENGTH) :-
    my_length(A, N),
    LENGTH is N + 1.

% 練習6: sumup/2の修正b1_sumup/2

b1_sumup(1, 1).
b1_sumup(N, X) :-
    N > 1,
    M is N - 1,
    b1_sumup(M, Y),
    X is N + Y.

% 練習7: sumup/2の修正b2_sumup/2

b2_sumup(1, 1) :- !.
b2_sumup(N, X) :-
    M is N - 1,
    b2_sumup(M, Y),
    X is N + Y,
    X > 0.

% 練習8: gennum/1

gennum(0).
gennum(N) :-
    gennum(N1),
    N is N1 + 1. % ここ自体ではfailせず、
                 % 外部のNに関する条件が落ちたらgennumのNに値が返る.
