-module(klunsr_product_controller, [Req]).
-compile(export_all).


list('GET', []) ->
    Products = boss_db:find(product, []),
    {ok, [{products, Products}]}.

add('GET', []) ->
    ok;
add('POST', [])->
    Title = Req:post_param("title"),
    Description = Req:post_param("description"),
    Product = product:new(id, Title , "fuf"),
    {ok, SavedProduct} = Product:save(),
    {redirect, [{action, "list"}]}.

add_image('GET', [Id]) ->
    %Product = boss_db:find(Id).
    ok;
%add_image('GET', [Id]) ->

view('GET', [Id]) ->
    Product = boss_db:find(Id),
    Images = boss_db:find(product_image, [{product_id, 'equals', Id}]),
    {ok, [{product, Product}]}.
