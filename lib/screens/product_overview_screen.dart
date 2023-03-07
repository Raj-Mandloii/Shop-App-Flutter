import 'package:flutter/material.dart';
import '../widgets/products_grid.dart';
// adding provider in root file
// import "pack"

class ProductOverviewScreen extends StatelessWidget {
  ProductOverviewScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text("🛒 Shop"),
        ),
        body: ProductsGrid());
  }
}
