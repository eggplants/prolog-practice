% factorial.pl

factorial(N, -1) :- not(integer(N)); N<0.
factorial(0, 1).
factorial(N, ANS) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, F1),
    ANS is N * F1.
