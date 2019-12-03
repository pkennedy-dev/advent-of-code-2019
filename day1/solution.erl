#! /usr/bin/env escript
main([InputFile]) ->
  {_, FileData} = file:read_file(InputFile),
  StrModules = lists:filter(fun(X) -> X =/= <<>> end, binary:split(FileData, <<"\n">>, [global])),
  IntModules = [element(1, string:to_integer(Mod)) || Mod <- StrModules],
  ModuleFuelCosts = [calculate_fuel(Mod) || Mod <- IntModules],
  io:format(integer_to_list(lists:sum(ModuleFuelCosts)));

main(_) ->
  usage().

usage() ->
  io:format("Please provide input file"),
  halt(1).

calculate_fuel(Module) ->
  floor(Module / 3) - 2.
