-module(erl15).
-export([start/0, ping/2, pong/0]).

ping(0, Pong_PID) ->
    Pong_PID ! finished, 
    io:format("Ping work ended~n", []);

ping(N, Pong_PID) ->
    Pong_PID ! {ping, self()}, 
    receive
        pong ->
            io:format("Ping received pong~n", [])
    end, 
    ping(N - 1, Pong_PID).

pong() ->
    receive
        finished ->
            io:format("Pong work ended~n", []);
        {ping, Ping_PID} ->
            io:format("Pong received ping~n", []), 
            Ping_PID ! pong, 
            pong()
    end.

start() ->
    Pong_PID = spawn(erl15, pong, []), 
    spawn(erl15, ping, [3, Pong_PID]).
