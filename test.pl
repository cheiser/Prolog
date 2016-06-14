car(bilen).
model(bilen, volvo, 740).
colorOf(bilen, red).
colorOf(bilen, black).
car(ama129).
car(fen292).
car(blb190).
model(ama129, volvo, 740).
model(fen292, ford, t).
model(abc111, ford, t).
model(blb190, volvo, 240).
colorOf(ama129, blue).
colorOf(blb190, white).
colorOf(C, black) :- model(C, ford, t).
brandColor(B, X) :- model(Y, B, Z), colorOf(Y, X).


length1([], 0).
length1([Head|Tail], N) :- length1(Tail, N1), N is 1+N1.


colors([red,green,blue,yellow,white]).
colors([lime, black]).

color3(X, [X|_]).
color3(X, [Head|Tail]) :- color3(X, Tail).
color2(X) :- colors(Y), color3(X, Y).

car2(X) :- model(X, _, _).

take(0, _, []).
take(X, [Head|Tail], [Head|R]) :- X1 is X-1, take(X1, Tail, R).

drop(0, X, X).
drop(X, [Head|Tail], R) :- X1 is X-1, drop(X1, Tail, R).



del(Head, [Head|Tail], Tail).
del(Head, [X|Tail], [X|Tail1]) :- del(Head, Tail, Tail1).


getValueAt(board([X/Y/Value|_]), X, Y, Value).
getValueAt(board([_|Tail]), X, Y, Value) :- getValueAt(board(Tail), X, Y, Value).

/*
getValueAt(board([1/1/x, 1/2/o, 2/1/x, 2/2/o]), X, Y, Value).
getValueAt(board([1/1/x, 1/2/o, 2/1/x, 2/2/o]), 1, 1, Value).
getValueAt(board([1/1/x, 1/2/o, 2/1/x, 2/2/o]), 1, 1, Value).
*/



setValueAt(board([X/Y/_|Tail]), X, Y, NewValue, board([X/Y/NewValue|Tail])).

setValueAt(board([Head|Tail]), X, Y, NewValue, NewBoard) :- setValueAt(board(Tail), X, Y, NewValue, Board), appendToBoard(Head, Board, NewBoard).


reverseValue(board([X/Y/Cur|Tail]), X, Y, board([X/Y/NewValue|Tail])) :- inverse(Cur, NewValue).
reverseValue(board([Head|Tail]), X, Y, NewBoard) :- setValueAt(board(Tail), X, Y, NewValue, Board), appendToBoard(Head, Board, NewBoard).

inverse(1, 2).
inverse(2, 1).

appendToBoard(Head, board([]), board([Head])).
appendToBoard(Head, board([H1|Tail]), board([Head, H1|Tail])).


getBoard(board([1/1/x, 1/2/o, 2/1/x, 2/2/o])).