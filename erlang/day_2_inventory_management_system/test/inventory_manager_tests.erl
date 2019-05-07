-module(inventory_manager_tests).
-include_lib("eunit/include/eunit.hrl").

produce_checksum_of_boxes_test() ->
    File = "ids.txt",
    Res = inventory_manager:checksum(File),
    ?assertEqual(4712, Res).

find_common_letters_of_correct_boxes_test() ->
    File = "ids.txt",
    Res = inventory_manager:find(File),
    ?assertEqual("lufjygedpvfbhftxiwnaorzmq", Res).
