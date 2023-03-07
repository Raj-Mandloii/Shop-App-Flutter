import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = "/product-detail";
  // const ProductDetail({super.key, required this.title, required this.price});
  // final String title;
  // final double price;

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProducts = Provider.of<Products>(context,listen: false).findById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProducts.title),
      ),
    );
  }
}
