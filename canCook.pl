at_home([ingredient(rice, 5), ingredient(salt, 1), ingredient(water, 10)]).


recipe(rice, [ingredient(rice, 4), ingredient(salt, 3), ingredient(water, 5)]).
recipe(saltwater, [ingredient(salt, 1), ingredient(water, 1)]).

/*
 * we can cook the food if we got an recipe on the food and we got the ingredients at home
 */
cook(X) :- recipe(X, Y), at_home(Z), looprecipe(Y, Z).

/*
 * if the recipe got no more needed ingredients then we need no more to be at home
 * if we got the first ingredient at home and the rest ingredients at home then we got the
 * ingredients we need at home
 */
 
looprecipe([], _).
looprecipe([Head|Tail], Y) :- gotathome(Head, Y), looprecipe(Tail, Y).

/*
 * if the amount we got at home is more than the amount needed we got enough
 * if the ingredient is not in the head of the list it may be in the rest of the "at home" list
 */
gotathome(Y, [X|_]) :- gotmorethan(Y, X). /* Y and X is in this case the same ingredient but they got different quantities */
gotathome(Y, [Head|Tail]) :- gotathome(Y, Tail).

/*
 * if the ingredients are of the same type and the amount we got is more than the amount needed
 * we got the amount needed.
 */
gotmorethan(ingredient(X, Y), ingredient(X, Z)) :- Z >= Y.



/*
 * we need to buy something to make the recipe if the recipe says that it is needed and we do not
 * got it at home
 */
buy(X, L) :- recipe(X, Y), at_home(Z), looprecipe1(Y, Z, L).


/*
 * if there are no more ingredients then there is no need to buy anymore
 * if the ingredient is at home then there is no need to buy it
 * if it is not at home then find what amount is missing and add it to the list
 */
looprecipe1([], _, []).
looprecipe1([Head|Tail], Y, L) :- gotathome(Head, Y), looprecipe1(Tail, Y, L).
looprecipe1([Head|Tail], Y, L) :- looprecipe1(Tail, Y, L1), addMissing(Head, Y, Z), append1(Z, L1, L).


/*
 * appending an empty list to an list is the second list
 * appending an list to another list is the same as appending the head to the result of appending
 * the rest(tail) to the other list.
 */
append1([], L1, L1).
append1([X|Z], L1, [X|L]) :- append1(Z, L1, L).

/*
 * if the ingredient does not exist at home add it to the buy list
 * if the ingredient exist but there is not an sufficent amount then find out how much is missing and add that
 * if the ingredient does not exist in the beginning of the list then continue to search in the rest of
 * the ingredients at home and see if it exist there.
 */
addMissing(X, [], [X|_]).
addMissing(X, [Head|Tail], L) :- firstMatch(X, Head), subtract(Head, X, L).
addMissing(X, [Head|Tail], L) :- addMissing(X, Tail, L). 


/*
 * see if there is two ingredients of the same type
 */
 
firstMatch(ingredient(X, _), ingredient(X, _)).

/*
 * if the amount of the one you got is 0 then the amount you need to buy is the amount needed
 * if the amount you got is more than 0 then subtract one from that and the amount you need
 */
subtract(ingredient(X, 0), ingredient(X,Z), [ingredient(X, Z)|_]).
subtract(ingredient(X, Y), ingredient(X, Z), L) :- Y1 is Y-1, Z1 is Z-1, subtract(ingredient(X, Y1), ingredient(X, Z1), L).


copy([],[]).
copy([X|Xs],[X|Ys]) :- copy(Xs,Ys).

addFirst(ingredient(X, Z), [ingredient(X, Z)|L]).
/*
 * different testing code:
 * subtract(ingredient(rice, 4), ingredient(rice, 7), L).
 * buy(rice, L).
 * 
 */