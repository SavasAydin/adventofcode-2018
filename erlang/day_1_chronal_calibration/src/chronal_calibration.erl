-module(chronal_calibration).
-export([total/1, reaches_twice/1]).

total(File) ->
    Tokens = tokenize(File),
    total(Tokens, 0).

total([], Res) ->
    Res;
total([H|T], Acc) ->
    {Frequency, _} = string:to_integer(H),
    total(T, Acc+Frequency).

reaches_twice(File) ->
    Tokens = tokenize(File),
    reaches_twice(Tokens, Tokens, 0, []).

reaches_twice([], Input, Total, Acc) ->
    reaches_twice(Input, Input, Total, Acc);
reaches_twice([H|T], Input, Total, Acc) ->
    {Frequency, _} = string:to_integer(H),
    NewTotal = Total+Frequency,
    case lists:member(NewTotal, Acc) of
        true ->
            NewTotal;
        false ->
            reaches_twice(T, Input, NewTotal, [NewTotal|Acc])
    end.

tokenize(File) ->
    {ok, Bin} = file:read_file(File),
    string:tokens(binary_to_list(Bin), "\n").


