-module(chronal_calibration_test).
-include_lib("eunit/include/eunit.hrl").

total_frequency_test() ->
    File = "frequency.txt",
    Res = chronal_calibration:total(File),
    ?assertEqual(599, Res).

first_frequency_reaches_twice_test_() ->
    {timeout, 20, fun first_frequency_reaches_twice/0}.

first_frequency_reaches_twice() ->
    File = "frequency.txt",
    Res = chronal_calibration:reaches_twice(File),
    ?assertEqual(81204, Res).
