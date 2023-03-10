import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = "/user-products";
  const UserProductScreen({Key? key}) : super(key: key);

  // Future<void> _refreshPro() async{
  //   return Provider.of<Products>(context,listen: false).fetchData();
  // make sure to add listen false;
  // }
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Products"),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProduct.routeName,arguments: null);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: 
      // to implement pull to refresh feature;
      // RefreshIndicator(
        //  onRefresh: ,
        // child: 
        Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (context, i) => UserProductItem(
                id: productsData.items[i].id,
                imageUrl: productsData.items[i].imageUrl,
                title: productsData.items[i].title),
          ),
        ),
      // ),
    );
  }
}
