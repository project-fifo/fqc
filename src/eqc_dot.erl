-module(eqc_dot).

-export([example_data/0, to_dot/1, to_dot/2, find_path/2]).

example_data() ->
    ?DATA.

to_dot(Data) ->
    to_dot(Data, undefined).

to_dot(Data, Error) ->
    Path = find_path(Data, Error),
    ["digraph {\n",
     [to_node(E, Path) || E <- Data],
     [to_line(E) || E <- Data],
     [[i2l(N - 1), " -> ", i2l(N), " [style=dashed]\n"] || N <- lists:seq(2, length(Data) - 1)],
     $}].

i2l(N) ->
    integer_to_list(N).

find_path(_Data, undefined) ->
    undefined;

find_path(Data, N) ->
    {N, sets:from_list(find_path(Data, [N], []) -- [N])}.

find_path(_, [], Parents) ->
    Parents;
find_path(Data, [N | R], Parents) ->
    case lists:member(N, Parents) of
        true ->
            find_path(Data, R, Parents);
        false ->
            case lists:nth(N+1, Data) of
                {set, {var, _N}, {call,_Mod,_Cmd, Args, _}} ->
                    NewParents = vars(Args),
                    R1 = lists:usort(NewParents ++ R),
                    find_path(Data, R1, [N | Parents]);
                _ ->
                    find_path(Data, R, [N | Parents])
            end
    end.

to_node({set,{var, Var},
         {call,_Mod,Cmd,
          Args,
          _}}, Path) ->
    VarS = integer_to_list(Var),
    [VarS, " [label=\"[", VarS, "] ", to_label(Cmd, Args), "\"]"]
        ++ color(Var, Path)
        ++ "\n";
to_node(_, _) ->
    [].

color(_Var, undefined) ->
    [];

color(Var, {Var, _}) ->
    " [color= \"red\"]";

color(Var, {N, Set}) ->
    case sets:is_element(Var, Set) of
        true ->
            " [color= \"green\"]";
        _ ->
            if
                N > Var ->
                    " [color= \"blue\"]";
                true ->
                    []
            end
    end.


to_line({set,{var, Var},
         {call,_Mod,_Cmd,
          Args,
          _}}) ->
    [to_line(Var, ID) || ID <- vars(Args)];
to_line(_) ->
    [].

vars(Args) ->
    lists:usort(vars1(Args)).

vars1([]) ->
    [];
vars1([{var, T} | R]) when is_integer(T) ->
    [T | vars(R)];
vars1([L | R]) when is_list(L) ->
    vars1(L) ++ vars1(R);
vars1([T | R]) when is_tuple(T) ->
    vars1(tuple_to_list(T)) ++ vars1(R);
vars1([_ | R]) ->
    vars1(R).


to_line(Var, T) ->
    TargetS = integer_to_list(T),
    [TargetS, " -> ", integer_to_list(Var),
     " [label=\"{var, ", TargetS, "}\"]\n"].


to_label(Cmd, Args) ->
    [atom_to_list(Cmd), "(",
     string:join([arg_to_str(Arg) || Arg <- Args], ", "),
     ")"].

arg_to_str(Arg) ->
    ArgS = io_lib:format("~p", [Arg]),
    ArgB = re:replace(ArgS, [$"], [$\\, $\\, $"], [global]),
    binary_to_list(list_to_binary(ArgB)).
