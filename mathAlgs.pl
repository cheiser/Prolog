isdivisible(X, Y) :- X mod Y =:= 0.
prime(X) :- isprime(X, 2).

isprime(X, X).
isprime(X, Y) :- not(isdivisible(X, Y)), Y1 is Y+1, isprime(X, Y1).

allprimes(1) :- write_ln(1).
allprimes(X) :- prime(X), X1 is X-1, allprimes(X1), write_ln(X).
allprimes(X) :- X1 is X-1, allprimes(X1).

/*
 * the sum of 0 is 0
 * the sum of all numbers smaller than X(inclusive X) is the sum of all number smaller than X added with X
 */
sum(0, 0) :- !.
sum(X, S) :- X1 is X-1, sum(X1, S1), S is S1+X.

/*
 * same principle as the normal sum except that here we build up the sum on the "way down" instead on the
 * backtrack
 */
sum1(X, S) :- sumA(X, 0, S).
sumA(0, S, S) :- !.
sumA(X, T, S) :- T1 is T+X, X1 is X-1, sumA(X1, T1, S).

/*
 * the faculty of 0 is 1
 * the faculty of X is the faculty of X-1 times X
 */
fac(0, 1) :- !.
fac(X, S) :- X1 is X-1, fac(X1, S1), S is S1*X.

/*
 * tail recursion
 */
fac1(X, S) :- facA(X, 1, S).
facA(0, S, S) :- !.
facA(X, T, S) :- T1 is T*X, X1 is X-1, facA(X1, T1, S).

/*
 * lists all the fibonacci numbers by simply see what the fibonacci number for that number is and then
 * print it
 */
fib(1) :- write_ln(1), !.
fib(X) :- X1 is X-1, fib(X1), fib1(X, S), write_ln(S).

/*
 * the fibonacci number of 1 is 1
 * the fibonacci number of 0 is 0
 * a fibonacci number is the sum of the two previous fibonacci numbers
 */
fib1(1, 1) :- !.
fib1(0, 0) :- !.
fib1(X, S) :- X1 is X-1, X2 is X-2, fib1(X1, S1), fib1(X2, S2), S is S1+S2.



fib2(X) :- fibA(X, 0, 0, 1).
/*
 * the fibonacci number of a number is the two previous fibonacci numbers.
 */
fibA(X, X, Prev1, Prev2) :- !.
fibA(X, Y, Prev1, Prev2) :- Y1 is Y+1, New is Prev1+Prev2, write_ln(New), fibA(X, Y1, New, Prev1).

/*
 * if the first number is divisible by the other the greatest common divisor is the second number
 * if not then the greatest common divisor is the greatest common divisor of the second number and 
 * the remainder of the division of the first and the second number.
 */
gcd(X, Y, Y) :- X mod Y =:= 0, !.
gcd(X, Y, Z) :- Y1 is X mod Y, gcd(Y, Y1, Z).

lcd(X, Y, 1).


/*
 * if Z is positive, then one should stop when X is bigger than Y
 * if Z is negative, then one should stop when X is smaller than Y
 * else print the number and correct the counter.
 */
for(X, Y, Z) :- Z > 0, X > Y, !.
for(X, Y, Z) :- Z < 0, X < Y, !.
for(X, Y, Z) :-  !, write_ln(X), X1 is X+Z, for(X1, Y, Z).

/*
 * X multiplication table is just adding itself to itselft a specific number of times
 */
table(X) :- Y is X * 10, for(X, Y, X).

perfect(X) :- sumofallproperdivisors(X, X, Z), Z1 is Z/2, X =:= Z1.
/*
 * sum of 1 is 1 and all numbers divisible by 1
 * if X is divisible by Y then Y is a proper divisor of X and should be added to the sum
 * else the number Y should not be added to the count
 */
sumofallproperdivisors(X, 1, 1) :- !.
sumofallproperdivisors(X, Y, Z) :- isdivisible(X, Y), !,  Y1 is Y-1, sumofallproperdivisors(X, Y1, Z1), Z is Z1+Y.
sumofallproperdivisors(X, Y, Z) :- Y1 is Y-1, sumofallproperdivisors(X, Y1, Z).

/*
 * if 1 is reached then there is no need to look for more numbers
 * if X is a perfect number it should be written and all perfect numbers smaller than it should be written
 * if X is not perfect print all perfect numbers smaller than it
 */
allperfect(1) :- !.
allperfect(X) :- perfect(X), !, write_ln(X), X1 is X-1, allperfect(X1).
allperfect(X) :- X1 is X-1, allperfect(X1).