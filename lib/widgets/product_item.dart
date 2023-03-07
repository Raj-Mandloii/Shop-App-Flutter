import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // const ProductItem(
  //     {Key? key, required this.id, required this.imageUrl, required this.title})
  //     : super(key: key);
  // final String id;
  // final String title;
  // final String imageUrl;
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetail.routeName, arguments: product.id);
        },
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: IconButton(
              icon: Icon(
                  product.isFavourite ? Icons.favorite : Icons.favorite_border),
              onPressed: () => product.toggleFavouriteStatus(),
              color: Theme.of(context).accentColor,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_bag),
              onPressed: (){},
              color: Theme.of(context).accentColor,
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
          ),
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
