% laboratorul 1
female(mary).
female(sandra).
female(juliet).
female(lisa).
male(peter).
male(paul).
male(dony).
male(bob).
male(harry).
parent(bob, lisa).
parent(bob, paul).
parent(bob, mary).
parent(juliet, lisa).
parent(juliet, paul).
parent(juliet, mary).
parent(peter, harry).
parent(lisa, harry).
parent(mary, dony).
parent(mary, sandra).

father_of(Father, Child) :- male(Father), parent(Father, Child).
mother_of(Mother, Child) :- female(Mother), parent(Mother, Child).
grandfather_of(Grandfather, Child) :- parent(Grandfather, Parent), parent(Parent, Child).
grandmother_of(Grandmother, Child) :- parent(Grandmother, Parent), parent(Parent, Child).
sister_of(Sister, Person) :- parent(Parent, Sister), parent(Parent, Person), female(Sister).
brother_of(Brother, Person) :- parent(Parent, Brother), parent(Parent, Person), male(Brother).
aunt_of(Aunt, Person) :- parent(Parent, Person), sister_of(Aunt, Parent).
uncle_of(Uncle, Person) :- parent(Parent, Person), brother_of(Uncle, Parent).

person(X) :- male(X); female(X).
not_parent(X, Y) :-  person(X), person(Y), \+ parent(X, Y).
