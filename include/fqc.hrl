%% Include this file at the END of _eqc.erl file!
%%
%% Allows running EQC in both EQC-CI and EQC offline. Placing eqc files in the
%% test directory will allow EUnit to automatically discover EQC tests by the
%% same rules EQC-CI does.
%% Also when running on the console output is nice and colored. The following
%% Makefile rules are handy when using rebar:
%%
%% qc: clean all
%%        $(REBAR) -C rebar_eqc.config compile eunit skip_deps=true --verbose
%%
%% eqc-ci: clean all
%%        $(REBAR) -D EQC_CI -C rebar_eqc.config compile eunit skip_deps=true --verbose
%%
%% The corresponding .eqc_ci file would look like this:
%%
%%{build, "make eqc-ci"}.
%%{test_path, "."}.
%%
%% EQC_NUM_TESTS and EQC_EUNIT_TIMEUT can be -defined in the file including this
%% if not they'll defualt to 500 tests and 60s

-ifdef(TEST).
-ifdef(EQC).

-include_lib("eqc/include/eqc.hrl").
-include_lib("eunit/include/eunit.hrl").

-import(fqc, [not_empty/1, maybe_oneof/2, non_blank_string/0, lower_char/0,
              pos_integer/0, non_neg_integer/0]).

-ifdef(EQC_CI).
-define(OUT(P),  on_output(fun(S,F) -> io:fwrite(user, S, F) end, P)).
-else.
-define(OUT(P),
        on_output(fun
                      (".", []) ->
                         io:fwrite(user, <<"\e[0;32m*\e[0m">>, []);
                      ("x", []) ->
                         io:format(user, <<"\e[0;33mx\e[0m">>, []);
                      ("Failed! ", []) ->
                         io:format(user, <<"\e[0;31mFailed! \e[0m">>, []);
                      (S, F) ->
                         io:format(user, S, F)
                 end, P)).
-endif.

-ifndef(EQC_NUM_TESTS).

-ifdef(EQC_LONG_TESTS).
-define(EQC_NUM_TESTS, 5000).
-else.  % EQC_LONG_TESTS
-ifdef(EQC_SHORT_TEST).
-define(EQC_NUM_TESTS, 100).
-else.  % EQC_SHORT_TEST
-define(EQC_NUM_TESTS, 500).
-endif. % EQC_SHORT_TEST
-endif. % EQC_LONG_TESTS

-endif. % EQC_NUM_TESTS

-ifndef(EQC_EUNIT_TIMEUT).
-define(EQC_EUNIT_TIMEUT, (?EQC_NUM_TESTS div 5)).
-endif.

-ifndef(EQC_SETUP).
run_test_() ->
    [{exports, E} | _] = module_info(),
    E1 = [{atom_to_list(N), N} || {N, 0} <- E],
    E2 = [{N, A} || {"prop_" ++ N, A} <- E1],
    [{"Running " ++ N ++ " propperty test",
      {timeout, ?EQC_EUNIT_TIMEUT, ?_assert(quickcheck(numtests(?EQC_NUM_TESTS,  ?OUT(?MODULE:A()))))}}
     || {N, A} <- E2].
-else.
run_test_() ->
    [{exports, E} | _] = module_info(),
    E1 = [{atom_to_list(N), N} || {N, 0} <- E],
    E2 = [{N, A} || {"prop_" ++ N, A} <- E1],
    [{setup,
      fun setup/0,
      fun cleanup/1,
      [{"Running " ++ N ++ " propperty test",
        {timeout, ?EQC_EUNIT_TIMEUT, ?_assert(quickcheck(numtests(?EQC_NUM_TESTS,  ?OUT(?MODULE:A()))))}}
       || {N, A} <- E2]}].
-endif.

-endif. % EQC
-endif. % Test
