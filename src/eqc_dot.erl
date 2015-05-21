-module(eqc_dot).

-export([example_data/0, to_dot/1, to_dot/2, find_path/2]).

-define(DATA, [{init,{{state,[],[],[],[],[],[],[],[]},
                       {var,admin}},
                      [{blocked_calls,[]},
                       {fresh_id,1},
                       {workers,[]},
                       {command_timeout,{var,command_timeout}},
                       {async_timeout,{var,async_timeout}},
                       {meta_cmd_stack,[]}]},
               {set,{var,1},
                {call,wiggle_eqc,connect,
                 [user1,"http://192.168.1.41"],
                 [{id,1},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,2},
                {call,wiggle_eqc,create_vm,
                 [{user,user1,{var,1},[]},
                  <<"c009ae95-d893-440e-b3f9-abd40d5f4d4a">>,
                  <<"75d1b5d8-e509-11e4-a51f-2fd538c62d87">>],
                 [{id,2},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,3},
                {call,wiggle_eqc,wait_for_creation,
                 [{var,admin},{var,2}],
                 [{id,3},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,4},
                {call,wiggle_eqc,stop_vm,
                 [{user,user1,{var,1},[{var,2}]},{var,2},true],
                 [{id,4},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,5},
                {call,wiggle_eqc,get_vm,
                 [{user,user1,{var,1},[{var,4}]},{var,4}],
                 [{id,5},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,6},
                {call,wiggle_eqc,get_vm,
                 [{user,user1,{var,1},[{var,4}]},{var,4}],
                 [{id,6},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,7},
                {call,wiggle_eqc,wait_for_stop,
                 [{var,admin},{var,4}],
                 [{id,7},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,8},
                {call,wiggle_eqc,start_vm,
                 [{user,user1,{var,1},[{var,4}]},{var,4}],
                 [{id,8},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,9},
                {call,wiggle_eqc,wait_for_start,
                 [{var,admin},{var,8}],
                 [{id,9},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,10},
                {call,wiggle_eqc,stop_vm,
                 [{user,user1,{var,1},[{var,8}]},{var,8},true],
                 [{id,10},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,11},
                {call,wiggle_eqc,wait_for_stop,
                 [{var,admin},{var,10}],
                 [{id,11},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,12},
                {call,wiggle_eqc,delete_vm,
                 [{user,user1,{var,1},[{var,10}]},{var,10}],
                 [{id,12},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,13},
                {call,wiggle_eqc,get_vm,
                 [{user,user1,{var,1},[{var,12}]},{var,12}],
                 [{id,13},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,14},
                {call,wiggle_eqc,create_vm,
                 [{user,user1,{var,1},[{var,12}]},
                  <<"c009ae95-d893-440e-b3f9-abd40d5f4d4a">>,
                  <<"75d1b5d8-e509-11e4-a51f-2fd538c62d87">>],
                 [{id,14},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,15},
                {call,wiggle_eqc,connect,
                 [user1,"http://192.168.1.42"],
                 [{id,15},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,16},
                {call,wiggle_eqc,wait_for_creation,
                 [{var,admin},{var,14}],
                 [{id,16},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,17},
                {call,wiggle_eqc,wait_for_delete,
                 [{var,admin},{var,12}],
                 [{id,17},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,18},
                {call,wiggle_eqc,create_vm,
                 [{user,user1,{var,15},[{var,14},{var,12}]},
                  <<"c009ae95-d893-440e-b3f9-abd40d5f4d4a">>,
                  <<"75d1b5d8-e509-11e4-a51f-2fd538c62d87">>],
                 [{id,18},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,19},
                {call,wiggle_eqc,stop_vm,
                 [{user,user1,{var,15},[{var,18},{var,14},{var,12}]},{var,14},true],
                 [{id,19},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,20},
                {call,wiggle_eqc,get_vm,
                 [{user,user1,{var,15},[{var,19},{var,18},{var,12}]},{var,19}],
                 [{id,20},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,21},
                {call,wiggle_eqc,wait_for_creation,
                 [{var,admin},{var,18}],
                 [{id,21},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,22},
                {call,wiggle_eqc,delete_vm,
                 [{user,user1,{var,15},[{var,19},{var,18},{var,12}]},{var,18}],
                 [{id,22},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,23},
                {call,wiggle_eqc,wait_for_stop,
                 [{var,admin},{var,19}],
                 [{id,23},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,24},
                {call,wiggle_eqc,delete_vm,
                 [{user,user1,{var,15},[{var,22},{var,19},{var,12}]},{var,19}],
                 [{id,24},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,25},
                {call,wiggle_eqc,list_vms,
                 [{user,user1,{var,15},[{var,24},{var,22},{var,12}]}],
                 [{id,25},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,26},
                {call,wiggle_eqc,connect,
                 [user2,"http://192.168.1.42"],
                 [{id,26},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,27},
                {call,wiggle_eqc,connect,
                 [user2,"http://192.168.1.42"],
                 [{id,27},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}},
               {set,{var,28},
                {call,wiggle_eqc,create_vm,
                 [{user,user1,{var,15},[{var,24},{var,22},{var,12}]},
                  <<"c009ae95-d893-440e-b3f9-abd40d5f4d4a">>,
                  <<"75d1b5d8-e509-11e4-a51f-2fd538c62d87">>],
                 [{id,28},{self,{var,{pid,root}}},{res,ok},{callouts,empty}]}}]).

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
