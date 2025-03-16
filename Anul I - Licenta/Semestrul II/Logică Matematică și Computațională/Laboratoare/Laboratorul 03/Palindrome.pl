palindrome([]).     % Orice șir vid este un palindrom
palindrome([_]).    % Orice șir de un caracter este un palindrom
palindrome(String) :-
    append([H|T], [H], String),
    palindrome(T).