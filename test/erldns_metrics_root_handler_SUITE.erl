-module(erldns_metrics_root_handler_SUITE).

-include_lib("common_test/include/ct.hrl").
-include_lib("eunit/include/eunit.hrl").

%% CT callbacks
-export([
    suite/0,
    all/0,
    init_per_suite/1,
    end_per_suite/1,
    init_per_testcase/2,
    end_per_testcase/2
]).

%% Tests
-export([to_json_test/1, to_html_test/1, to_text_test/1]).

all() -> [to_json_test, to_html_test, to_text_test].

suite() -> [].

init_per_suite(Config) ->
    {ok, _} = application:ensure_all_started(erldns_metrics),
    Config.

end_per_suite(_Config) ->
    application:stop(erldns_metrics),
    ok.

init_per_testcase(_TestCase, Config) ->
    Config.

end_per_testcase(_TestCase, _Config) ->
    ok.

to_json_test(_Config) ->
    Req = {},
    State = {},
    {Body, Req, State} = erldns_metrics_root_handler:to_json(Req, State),
    DecodedBody = json:decode(Body),
    ?assertMatch(
        #{
            <<"erldns">> := #{
                <<"metrics">> := _,
                <<"stats">> := _,
                <<"vm">> := #{<<"memory">> := #{<<"atom">> := _}},
                <<"ets">> := _,
                <<"processes">> := _
            }
        },
        DecodedBody
    ),
    ok.

to_html_test(_Config) ->
    ?assertMatch(
        {<<"erldns metrics">>, _, _},
        erldns_metrics_root_handler:to_html({}, {})
    ).

to_text_test(_Config) ->
    ?assertMatch(
        {<<"erldns metrics">>, _, _},
        erldns_metrics_root_handler:to_text({}, {})
    ).
