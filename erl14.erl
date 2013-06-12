-module(erl14).
-export([start/0, say_something/2]).

say_something(What, 0) ->
    done;
say_something(What, Times) ->
    io:format("~p~n", [What]), 
    say_something(What, Times - 1).

start() ->
    spawn(?MODULE, say_something, [hello1, 3]), 
    spawn(?MODULE, say_something, [hello2, 3]), 
    spawn(?MODULE, say_something, [goodbye1, 3]), 
    spawn(?MODULE, say_something, [goodbye2, 3]).
