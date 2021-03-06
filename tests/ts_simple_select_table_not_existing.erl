%% -------------------------------------------------------------------
%%
%% Copyright (c) 2015-2016 Basho Technologies, Inc.
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% -------------------------------------------------------------------

-module(ts_simple_select_table_not_existing).

-behavior(riak_test).

-include_lib("eunit/include/eunit.hrl").

-export([confirm/0]).

confirm() ->
    Qry =
        "SELECT * FROM dne "
        "WHERE time > 1 AND time < 10",
    Expected = {error,{1019,<<"dne is not an active table">>}},

    Cluster = ts_setup:start_cluster(1),
    Got = ts_ops:query(Cluster, Qry),
    ?assertEqual(Expected, Got),
    pass.
