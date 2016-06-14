islist([]).
islist([X|_]).

islist1([]).
islist1([_|X]) :- islist1(X).

member1(X, [X|_]) :- !.
member1(X, [Head|Tail]) :- member1(X, Tail).



dispatch(monday, [lot506, lot737, lot738, lot741, lot890]).
dispatch(tuesday, [lot663, lot667 ]).
dispatch(wednesday, [ ]).
fragile([lot738, lot741, lot667, lot506]).

specialpd(X, Y) :- dispatch(X, Z), fragile(T), specialp(Z, T, Y).

specialp([], T, []).
specialp([Head|Tail], T, [Head|Y]) :- member1(Head, T), !, specialp(Tail, T, Y).
specialp([Head|Tail], T, Y) :- specialp(Tail, T, Y).

/*
 * the flattening of an empty list is the empty list
 * the flattening of a list that got a list as a head is the flattening of the head concatenated with 
 * the flattening of the rest of the list
 * if the head is not a list then the flattenating of the list is the head concatenated with the 
 * flattening of the rest of the list
 */
flatten([], []).
flatten([Head|Tail], [FlattenHead|FlattenTail]) :- islist(Head), !, flatten2(Head, FlattenHead), flatten(Tail, FlattenTail).
flatten([Head|Tail], [Head|Y]) :- flatten(Tail, Y).

getfirst([Head|Tail], Head, Tail).