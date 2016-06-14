/*
 * a number is a natural number if it is 0 or a predecessor to 0
 */
natural_number(0).
natural_number(s(X)):-natural_number(X).

/*
 * when you add 0 and a natural number the result is the number
 * adding a number and another number is the same as adding the number-1 and the other number and then
 * adding one to the result
 */
add(0,X,X):-natural_number(X).
add(s(X),Y,s(Z)):-add(X,Y,Z).

/*
 * the translation of 0 is 0
 * the translation of a natural number is the translation of the predecessor of that number plus one
 */
translate(0, 0).
translate(s(N), X) :- translate(N, Y), X is Y+1.

/*
 * subtracting 0 from a number yields the number
 * subtracting a number from a number is the same as subtracting a the predecessor of number from the
 * predecessor of a number
 */ 
sub(X, 0, X) :- natural_number(X).
sub(s(X), s(Y), Z) :- sub(X, Y, Z).

/*
 * if you add two numbers together and and you only know one of the numbers then the result - that number
 * is the other number
 */
sub1(X, Y, Z) :- add(Y, Z, X).


/*
 * multiplying one number by 0 yields 0
 * multiplying one number by another is the same as multiplying the number-1 and then add the second
 * number to the result
 */
mult(0, Y, 0) :- natural_number(Y).
mult(s(X), Y, Z) :- mult(X, Y, Z1), add(Z1, Y, Z).

/*
 * raising one number to the power of 0 is 1
 * raising one number to the power of another is the same as raising the number to the other number-1
 * and then multiply by the first number
 */
pow(X, 0, s(0)).
pow(X, s(Y), Z) :- pow(X, Y, Z1), mult(X, Z1, Z).

/*
 * the faculty of 0 is one
 * the faculty of a number is the faculty of that number-1 times the number
 */
fac(0, s(0)).
fac(s(X), Y) :- fac(X, Y1), mult(s(X), Y1, Y).
 
/*
 * 0 is less than any number that is bigger than 0(that is that has an predecessor for natual numbers)
 * a number is less than another if that number-1 is less than the other number-1
 */
lessThan(0, s(Y)) :- natural_number(Y).
lessThan(s(X), s(Y)) :- lessThan(X, Y).
 
/*
 * 0 is less than equal any natural number
 * a number is less than equals another if subtracting one from each of the numbers and the number is still
 * less than equals
 */
lessThane(0, Y) :- natural_number(Y).
lessThane(s(X), s(Y)) :- lessThane(X, Y).

/*
 * a number that is bigger than 0(has predecessor) is bigger than another number if that number is 0
 */
greaterThan(s(X), 0) :- natural_number(X).
greaterThan(s(X), s(Y)) :- greaterThan(X, Y).

/*
 * a number is greater than equals another if it is not less than the other
 */
greaterThane(X, Y) :- lessThane(Y, X).

/*
 * a natural number is equal another number if it is the two numbers are "the same"
 */
equals(X, X).



/*
 * X*Y = Z
 * X = Z/Y
 * when you got the result Z and you know one of the number(Y) the other number is Z divided with Y.
 * the number needed to get the result Z is the same as Z divided with Y.
 */
div1(X, Y, Z) :- mult(Y, Z, X).

/*
 * the result of an "heltalsdivision" is the same as the number of times you can subtract the number from
 * the other, that is as long as the number that is to get divided is bigger than the one thats dividing.
 */
div(X, Y, s(Z)) :- greaterThane(X, Y), sub(X, Y, X1), div(X1, Y, Z).
div(X, Y, 0).

/*
 * the remainder of an division is the result of subtracting the smaller number from
 * the bigger until the smaller is bigger than the result.
 */

modulus(X, Y, Z) :- greaterThane(X, Y), sub(X, Y, X1), modulus(X1, Y, Z).
modulus(X, Y, X).

