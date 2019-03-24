-module(count_nitrogenous_base).
-export([start/0, rpc/2, server/0, monitoring/2]).
-export([count_nb/5]).

start() ->
    spawn(?MODULE, server, []).

rpc(Pid, Ask) ->
    Pid ! {self(), Ask},
    receive
	{Pid, Response} ->
	    Response
    end.

server() ->
    receive
	{From, {count_atcg, A, T, G, C, String}} ->
	    From ! {self(), count_nb(A, T, G, C, String)},
	    server();
	{From, Other} ->
	    From ! {self(), {error, Other}},
	    server()
    end.

monitoring(Pid, Fn) ->
    spawn(fun() ->
		  Ref = monitor(process, Pid),
		  receive
		      {'DOWN', Ref, process, Pid, Why} ->
			  Fn(Why)
		  end
	  end).

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
