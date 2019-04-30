-module(chronal_calibration_test).
-include_lib("eunit/include/eunit.hrl").

frequency_test() ->
    File = "frequency.txt",
    Res = chronal_calibration:calculate(File),
    ?assertEqual(599, Res).
