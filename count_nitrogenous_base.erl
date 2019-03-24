-module(count_nitrogenous_base).
-export([start/0, rpc/1, server/0, restarter/0]).
-export([count_nb/5]).

start() ->
    spawn(?MODULE, restarter, []).

% Thanks Fred Hébert :)
restarter() ->
    process_flag(trap_exit, true),
    Pid = spawn_link(?MODULE, server, []),
    register(serverproc, Pid),
    receive
	{'EXIT', Pid, normal} ->
	    ok;
	{'EXIT', Pid, shutdown} ->
	    ok;
	{'EXIT', Pid, _} ->
	    restarter()
    end.

server() ->
    receive
	{From, Ref, {count_atcg, A, T, G, C, String}} ->
	    From ! {Ref, count_nb(A, T, G, C, String)},
	    server();
	{From, Ref, Other} ->
	    From ! {Ref, {error, Other}},
	    server()
    end.

rpc(Ask) ->
    Ref = make_ref(),
    serverproc ! {self(), Ref, Ask},
    receive
	{Ref, Response} ->
	    Response
    after 2000 ->
	    timeout
    end.

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


% 1> c(count_nitrogenous_base).
% {ok,count_nitrogenous_base}
% 2> count_nitrogenous_base:start().
% <0.84.0>
% 3> count_nitrogenous_base:rpc({count_atcg, 0,0,0,0, "atcg"}).
% [1,1,1,1]
% 4> count_nitrogenous_base:rpc({"atcg"}).
% {error,{"atcg"}}
% 5> exit(whereis(serverproc), kill).
% true
% 6> count_nitrogenous_base:rpc({count_atcg, 0,0,0,0, "atcga"}).
% [2,1,1,1]
