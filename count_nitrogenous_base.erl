-module(count_nitrogenous_base).
-export([count_nb/5]).

count_nb(_A, _T, _G, _C, []) ->
    [_A | [ _T | [ _G | [_C | []]]]];
count_nb(A, T, G, C, [H|Cdr]) when  H == $A; H == $a ->
    count_nb(A+1, T, G, C, Cdr);
count_nb(A, T, G, C, [H|Cdr]) when H == $T; H == $t ->
    count_nb(A, T+1, G, C, Cdr);
count_nb(A, T, G, C, [H|Cdr]) when H == $G; H == $g ->
    count_nb(A, T, G+1, C, Cdr);
count_nb(A, T, G, C, [H|Cdr]) when H == $C; H == $c ->
    count_nb(A,T,G,C+1,Cdr).
