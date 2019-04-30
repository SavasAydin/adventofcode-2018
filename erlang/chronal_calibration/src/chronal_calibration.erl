-module(chronal_calibration).
-export([calculate/1]).

calculate(File) ->
    {ok, Bin} = file:read_file(File),
    Tokens = string:tokens(binary_to_list(Bin), "\n"),
    calculate(Tokens, 0).

calculate([], Res) ->
    Res;
calculate([H|T], Acc) ->
    {Frequency, _} = string:to_integer(H),
    calculate(T, Acc+Frequency).
