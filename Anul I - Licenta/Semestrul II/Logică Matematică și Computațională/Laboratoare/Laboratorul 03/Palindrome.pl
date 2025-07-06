palindrome([]).     % Orice șir vid este un palindrom
palindrome([_]).    % Orice șir de un caracter este un palindrom
palindrome([H|T]) :-
    append(Mid, [H], T),
    palindrome(Mid).