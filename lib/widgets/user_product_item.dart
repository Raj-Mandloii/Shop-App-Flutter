import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product.dart';

class UserProductItem extends StatelessWidget {
  const UserProductItem({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);
  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProduct.routeName,
                arguments: id
                
                );
              },
              icon: const Icon(Icons.edit),
              color: Colors.teal,
            ),
            IconButton(
              onPressed: () {
                Provider.of<Products>(context,listen: false).deleteProduct(id);
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
