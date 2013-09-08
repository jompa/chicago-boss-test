-module(klunsr_product_image_controller, [Req]).
-compile(export_all).


list('GET', [Id]) ->
    ProductImages = boss_db:find(product_image, [{product_id, 'equals', Id}]),
    {ok, [{product_images, ProductImages}]}.


add('GET', []) ->
    ok;
add('POST', [])->
    [{uploaded_file, FileName, Location, Length, _}] = Req:post_files(),
    Fname = "./priv/static/media/products/" ++ FileName,
    file:copy(Location, Fname),
    file:delete(Location),
    Title = Req:post_param("title"),
    Description = Req:post_param("description"),
    Product = product:new(id, Title, Description, "/static/media/products/" ++ FileName),
    {ok, SavedProduct} = Product:save(),
    {redirect, [{action, "list"}]}.
