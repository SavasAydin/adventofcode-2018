-module(inventory_manager).
-export([checksum/1,
         find/1]).

checksum(File) ->
    Ids = tokenize(File),
    {Twos, Threes} = checksum(Ids, 0, 0),
    Threes * Twos.

find(File) ->
    Ids = tokenize(File),
    find_common_letters(Ids).

%%% ----------------------------------------------------------------------------
tokenize(File) ->
    {ok, Bin} = file:read_file(File),
    string:tokens(binary_to_list(Bin), "\n").

%%% ----------------------------------------------------------------------------
checksum([], TwoTimes, ThreeTimes) ->
    {TwoTimes, ThreeTimes};
checksum([Id | Ids], TwoTimes, ThreeTimes) ->
    {Two, Three} = count(lists:sort(Id), 0, 0),
    checksum(Ids, TwoTimes+Two, ThreeTimes+Three).

count([_], TwoAcc, ThreeAcc) ->
    {TwoAcc, ThreeAcc};
count([X, X], _, ThreeAcc) ->
    {1, ThreeAcc};
count([X, X, X], TwoAcc, _) ->
    {TwoAcc, 1};
count([X, X, Y | T], _, ThreeAcc) when X /= Y ->
    count([Y | T], 1, ThreeAcc);
count([X, X, X, Y | T], TwoAcc, _) when X /= Y ->
    count([Y | T], TwoAcc, 1);
count([_ | T], TwoAcc, ThreeAcc) ->
    count(T, TwoAcc, ThreeAcc).

%%% ----------------------------------------------------------------------------
find_common_letters([]) ->
    {error, correct_box_not_found};
find_common_letters([Id | Ids]) ->
    case common_letters(Id, Ids) of
        false ->
            find_common_letters(Ids);
        CommonLetters ->
            CommonLetters
    end.

common_letters(_, []) ->
    false;
common_letters(Letters, [Id|Ids]) ->
    case differ_by_one_character(Letters, Id, [], 0) of
        false ->
            common_letters(Letters, Ids);
        CommonLetters ->
            CommonLetters
    end.

differ_by_one_character([], [], Same, 1) ->
    lists:reverse(Same);
differ_by_one_character([], [], _, 0) ->
    false;
differ_by_one_character([L | Letters], [L | T], Acc, N) ->
    differ_by_one_character(Letters, T, [L | Acc], N);
differ_by_one_character([_ | Letters], [_ | T], Acc, 0) ->
    differ_by_one_character(Letters, T, Acc, 1);
differ_by_one_character(_, _, _, 1) ->
    false.

