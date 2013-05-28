-module(posts, [Id, Title,Body,Pic,Url,Create_at]).
-compile(export_all).

validation_tests() ->
    [{fun() -> length(Title) > 0 end, "Page Title cannot be empty."},
     {fun() -> length(Body) =< 1000 end, "Page Text cannot be more than 32 characters long."}].
