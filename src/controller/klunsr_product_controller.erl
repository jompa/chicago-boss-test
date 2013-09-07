-module(klunsr_product_controller, [Req]).
-compile(export_all).

hello('GET', [])->
    {output, "Hello, world!"}.

list('GET', []) ->
    Products = boss_db:find(product, []),
    {ok, [{products, Products}]}.

add('GET', []) ->
    ok;
add('POST', [])->
    [{uploaded_file, FileName, Location, Length, _}] = Req:post_files(),
    Fname = "./priv/static/products/" ++ FileName,
    file:copy(Location, Fname),
    file:delete(Location),
    Title = Req:post_param("Title"),
    Description = Req:post_param("Description"),
    Product = product:new(id, Title, Description, "/static/products/" ++ FileName),
    {ok, SavedProduct} = Product:save(),
    {redirect, [{action, "list"}]}.
