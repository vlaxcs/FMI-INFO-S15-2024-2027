% P47 (*) Truth tables for logical expressions (2).
% Continue problem P46 by defining and/2, or/2, etc as being
% operators. This allows to write the logical expression in the
% more natural way, as in the example: A and (A or not B).
% Define operator precedence as usual; i.e. as in Java.
%
% Example:
% ?- table(A,B, A and (A or not B)).
% true  true  true
% true  fail  true
% fail  true  fail
% fail  fail  fail
    
:- ensure_loaded(p46).

:- op(900, fy,not).
:- op(910, yfx, and).
:- op(910, yfx, nand).
:- op(920, yfx, or).
:- op(920, yfx, nor).
:- op(930, yfx, impl).
:- op(930, yfx, equ).
:- op(930, yfx, xor).

% I.e. not binds stronger than (and, nand), which bind stronger than
% (or,nor) which in turn bind stronger than implication, equivalence
% and xor.
