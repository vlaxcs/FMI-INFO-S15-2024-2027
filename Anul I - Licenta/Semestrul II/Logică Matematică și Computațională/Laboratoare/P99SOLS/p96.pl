% P96 (**) Syntax checker for Ada identifiers

% A purely recursive syntax is:
%
% <identifier> ::= <letter> <rest>
%
% <rest> ::=  | <optional_underscore> <letter_or_digit> <rest>
%
% <optional_underscore> ::=  | '_'
%
% <letter_or_digit> ::= <letter> | <digit>

% identifier(Str) :- Str is a legal Ada identifier
%    (atom) (+)

identifier(S) :- atom(S), atom_chars(S,L), identifier(L).

identifier([X|L]) :- char_type(X,alpha), rest(L).

rest([]) :- !.
rest(['_',X|L]) :- !, letter_or_digit(X), rest(L).
rest([X|L]) :- letter_or_digit(X), rest(L).

letter_or_digit(X) :- char_type(X,alpha), !.
letter_or_digit(X) :- char_type(X,digit).

% Try also a solution with difference lists!
% See p96a.pl
