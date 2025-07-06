% P72 (*) Construct the bottom-up order sequence of the tree nodes

% bottom_up(Tree,Seq) :- Seq is the bottom-up sequence of the nodes of
%    the multiway tree Tree. (+,?)

bottom_up_f(t(X,F),Seq) :- 
	bottom_up_f(F,SeqF), append(SeqF,[X],Seq).

bottom_up_f([],[]).
bottom_up_f([T|Ts],Seq):-
	bottom_up_f(T,SeqT), bottom_up_f(Ts,SeqTs), append(SeqT,SeqTs,Seq).

% The predicate bottom_up/2 produces a stack overflow when called
% in the (-,+) flow pattern. There are two problems with that.
% First, the polymorphism does not work properly, because during
% decomposing the string, the program cannot guess whether it should
% construct a tree or a forest next. We can fix this using two
% separate predicates bottom_up_tree/2 and bottom_up_forset/2.
% Secondly, if we maintain the order of the subgoals, then
% the interpreter falls into an endless loop after finding the
% first solution. We can fix this by changing the order of the
% goals as follows:

bottom_up_tree(t(X,F),Seq) :-                        % (?,+)
	append(SeqF,[X],Seq), bottom_up_forest(F,SeqF).

bottom_up_forest([],[]).
bottom_up_forest([T|Ts],Seq):-
	append(SeqT,SeqTs,Seq),
	bottom_up_tree(T,SeqT), bottom_up_forest(Ts,SeqTs).

% Unfortunately, this version doesn't run in both directions either.

% In order to have a predicate which runs forward and backward, we
% have to determine the flow pattern and then call one of the above
% predicates, as follows:

bottom_up(T,Seq) :- nonvar(T), !, bottom_up_f(T,Seq).
bottom_up(T,Seq) :- nonvar(Seq), bottom_up_tree(T,Seq).

% This is not very elegant, I agree.