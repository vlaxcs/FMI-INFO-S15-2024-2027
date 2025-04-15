% bnon/2, bsi/3, bsau/3, bimp/3

bnon(0, 1).
bnon(1, 0).

bsi(0, 0, 0).
bsi(0, 1, 0).
bsi(1, 0, 0).
bsi(1, 1, 1).

bsau(0, 0, 0).
bsau(1, 0, 1).
bsau(0, 1, 0).
bsau(1, 1, 1).

bimp(0, 0, 1).
bimp(0, 1, 1).
bimp(1, 0, 0).
bimp(1, 1, 1).

% ?- bsi(1,0,C).
% C = 0 .

% ?- bimp(A,0,0).
% A = 1.

% ?- bimp(0,B,0).
% false.