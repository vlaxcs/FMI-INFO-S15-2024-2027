% P56 (**) Symmetric binary trees 
% Let us call a binary tree symmetric if you can draw a vertical 
% line through the root node and then the right subtree is the mirror
% image of the left subtree.
% Write a predicate symmetric/1 to check whether a given binary
% tree is symmetric. Hint: Write a predicate mirror/2 first to check
% whether one tree is the mirror image of another.

% symmetric(T) :- the binary tree T is symmetric.

symmetric(nil).
symmetric(t(_,L,R)) :- mirror(L,R).

mirror(nil,nil).
mirror(t(_,L1,R1),t(_,L2,R2)) :- mirror(L1,R2), mirror(R1,L2).
