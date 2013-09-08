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
    Product = product:new(id, Title , Description),
    {ok, SavedProduct} = Product:save(),
    {redirect, [{action, "list"}]}.

delete('GET', [Id]) ->
    Product = boss_db:find(Id),
    {ok, [{product, Product}]};
delete('POST', [])->
    Title = Req:post_param("title"),
    Description = Req:post_param("description"),
    Product = product:new(id, Title , Description),
    {ok, SavedProduct} = Product:save(),
    {redirect, [{action, "list"}]}.

add_image('GET', []) ->
    {redirect, [{action, "list"}]};
add_image('GET', [Id]) ->
    Product = boss_db:find(Id),
    {ok, [{product, Product}]};
add_image('POST', [Id]) ->
    [{uploaded_file, FileName, Location, Length, _}] = Req:post_files(),
    Fname = "./priv/static/media/products/" ++ FileName,
    file:copy(Location, Fname),
    file:delete(Location),
    Title = Req:post_param("title"),
    ProductImage = product_image:new(id, Id, "/static/media/products/" ++ FileName),
    {ok, SavedProductImage} = ProductImage:save(),
    {redirect, [{action, "list"}]}.

view('GET', [Id]) ->
    Product = boss_db:find(Id),
    Images = boss_db:find(product_image, [{product_id, 'equals', Id}]),
    {ok, [{product, Product}, {product_images, Images}]}.
