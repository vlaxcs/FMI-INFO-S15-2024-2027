% P48 (**) Truth tables for logical expressions (3).
% Generalize problem P47 in such a way that the logical
% expression may contain any number of logical variables.
%
% Example:
% ?- table([A,B,C], A and (B or C) equ A and B or A and C).
% true  true  true  true
% true  true  fail  true
% true  fail  true  true
% true  fail  fail  true
% fail  true  true  true
% fail  true  fail  true
% fail  fail  true  true
% fail  fail  fail  true

:- ensure_loaded(p47).    

% table(List,Expr) :- print the truth table for the expression Expr,
%   which contains the logical variables enumerated in List.

table(VarList,Expr) :- bindList(VarList), do(VarList,Expr), fail.

bindList([]).
bindList([V|Vs]) :- bind(V), bindList(Vs).

do(VarList,Expr) :- writeVarList(VarList), writeExpr(Expr), nl.

writeVarList([]).
writeVarList([V|Vs]) :- write(V), write('  '), writeVarList(Vs).

writeExpr(Expr) :- Expr, !, write(true).
writeExpr(_) :- write(fail).
