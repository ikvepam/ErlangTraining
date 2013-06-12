-module(erl17).
-export([start_ping/1, start_pong/0,  ping/2, pong/0]).

ping(0, Pong_Node) ->
    {pong, Pong_Node} ! finished, 
    io:format("Ping work ended~n", []);

ping(N, Pong_Node) ->
    {pong, Pong_Node} ! {ping, self()}, 
    receive
        pong ->
            io:format("Ping receive pong~n", [])
    end, 
    ping(N - 1, Pong_Node).

pong() ->
    receive
        finished ->
            io:format("Pong work ended~n", []);
        {ping, Ping_PID} ->
            io:format("Pong receive ping~n", []), 
            Ping_PID ! pong, 
            pong()
    end.

start_pong() ->
    register(pong, spawn(erl17, pong, [])).

start_ping(Pong_Node) ->
    spawn(erl17, ping, [3, Pong_Node]).
