move(N, A, C) :- writeln(move(N, from, A, to, C)).
hanoi1(1, A, C, _, 1) :- move(1, A, C).
hanoi1(N, A, C, B, Z) :- N1 is N - 1,
    hanoi1(N1, A, B, C, X),
    move(N, A, C),
    hanoi1(N1, B, C, A, Y),
    Z is X + 1 + Y.