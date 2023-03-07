import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  static const routeName = "/product-detail";
  // const ProductDetail({super.key, required this.title, required this.price});
  // final String title;
  // final double price;

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
    );
  }
}
