member(A, [A|_]).
member(A, [B|_]) :- member(A, [B]).
