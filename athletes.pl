plays(john, tennis).
plays(pat, tennis).
plays(mary, tennis).
plays(liza, tennis).

plays(john, golf).
plays(liza, golf).
plays(mary, golf).

plays(john, baseball).

beats(john, mary, tennis).
beats(mary,  liza, tennis).
beats(liza, pat, tennis).

beats(john, liza, golf).
beats(liza, mary, golf).

athlete(X) :- plays(X, _).

onesport(X) :- plays(X, Y), not((plays(X, Z), Y \= Z)).

twosports(X) :- plays(X, Y), plays(X, Z), Z \= Y, not((plays(X, T), T \= Z, T \= Y)).

best(X, Y) :- beats(X, Z, Y), not(beats(T, X, Y)).

worst(X, Y) :- beats(Z, X, Y), not(beats(X, T, Y)).

betterthan(X, Y, Z) :- beats(X, Y, Z).
betterthan(X, Y, Z) :- beats(X, T, Z), betterthan(T, Y, Z).

better_golf_and_tennis(X, Y) :- betterthan(X, Y, tennis), betterthan(X, Y, golf).