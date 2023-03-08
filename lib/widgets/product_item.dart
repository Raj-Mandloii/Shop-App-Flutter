import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import '../providers/cart.dart';
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
    // 1st way of consuming data
    //  final product = Provider.of<Product>(context);
     final cart = Provider.of<Cart>(context,listen: false);

    // alternate way to wrap the part of widget to consumer widget.
    // example below ==>
    return Consumer<Product>(
      // about child 
      // you can pass child in consumer 
      // however the child never changes
      builder: (context, product, child) => ClipRRect(
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
                icon: Icon(product.isFavourite
                    ? Icons.favorite
                    : Icons.favorite_border),
                onPressed: () => product.toggleFavouriteStatus(),
                color: Theme.of(context).accentColor,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.shopping_bag),
                onPressed: () {
                  cart.addItem(product.id, product.price, product.title);
                },
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
      ),
    );
  }
}
