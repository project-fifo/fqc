# FQC - FiFo Quickcheck helper

A set of helpers for running EQC. It uses the same logic as quickcheck-ci.org to determine what tests to run (functions ending with _prop) and wraps it in a eunit test suite.

Some functions are provided for additional generators. Also it offers colored output for tests instead of the default printing of results.


Simply put `-include_lib("fqc/include/fqc.hrl").` in your file.

In addition to that some variables can be `-defined`:

* `EQC_SETUP` When defined the module must provide `setup/0` and `cleanup/1` which will be used as part of the eunit test suite.
* `EQC_NUM_TESTS` The number of tests to run, default is 500.
* `EQC_LONG_TESTS` Runs 5000 tests.
* `EQC_SHORT_TEST` Runs 100 tests.
* `EQC_EUNIT_TIMEUT` The timeout for the unit tests, defaults to `?EQC_NUM_TESTS div 5`.
* `EQC_CI` Disables colored output to run with EQC_CI.
* `GROWL` If defined a growl notification will be send for failed test cases using `growlnotify -n eqc -m "A test failed"`

# Statemachien visualisation

The eqc_dot module provides a function to generate `.dot` files for graphviz from symbolic statemachine commands.

The main function is `eqc_gv:to_dot/2` where the first argument is the list symbilic commands and the second the failed command:


```erlang
file:write_file("/Users/heinz/test.dot", eqc_gv:to_dot(eqc_gv:example_data(), 6)).
```

* The Red command is the failed command.
* Green commands were successfully executed and are in the dependency path of the failed command.
* Blue commands were executed but their results were not used by the failed command.