-module(tiny-boss_posts_controller, [Req]).
-compile(export_all).

%%home
index('GET', []) ->
    Posts = boss_db:find(posts, []),
    {ok, [{say, "Hello"},{posts, Posts}]}.


%%posts list 
posts_list('GET',[])->
    Posts = boss_db:find(posts, []),
    {ok, [{posts, Posts}]}.
    %{ok, [{posts, Posts}]}.


%%add posts
posts_add('GET', []) ->
    ok;
posts_add('POST', []) ->
    Title = Req:post_param("title"),
    Body = Req:post_param("body"),
    [{uploaded_file, FileName, Location, Length}] = Req:post_files(),
    {output, [FileName], [{"Content-Type", "image/gif"}]},
    Date = erlang:now(),
    Posts = posts:new(id,Title,Body,FileName,Location,Date),
    {ok, SavedPosts} = Posts:save(),
    {redirect, [{action, "posts_list"}]}.


%%del posts
posts_del('GET', [Id]) ->
    ok = boss_db:delete(Id),
    {redirect, [{action, "posts_list"}]}.


%%edit posts 
posts_edit('GET', [Id]) ->
    Posts = boss_db:find(Id),
    {ok, [{posts,Posts}]};
posts_edit('POST',[Id]) ->
    Posts = boss_db:find(Id),
    Title = Req:post_param("title"),
    Body = Req:post_param("body"),
    Date = erlang:now(),
    Flsh = Posts:set([{id,Id},{title,Title},{body,Body},{create_at,Date}]),
    {ok,NewFlsh}=Flsh:save(),
    {redirect, [{action, "posts_list"}]}.



%%posts detail
post_detail('GET',[Id]) ->
    Posts = boss_db:find(Id),
    {ok, [{posts, Posts}]}.
