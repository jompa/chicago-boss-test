-module(product_image, [Id, ProductId, Image::string()]).
-compile(export_all).

-belongs_to(product).
