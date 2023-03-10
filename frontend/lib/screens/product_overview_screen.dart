import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/CartScreen.dart';
import '../widgets/app_drawer.dart';
import 'package:shop_app/widgets/customBadge.dart';
import '../widgets/products_grid.dart';
// adding provider in root file
// import "pack"

enum FilterOptions { Favourite, All }

class ProductOverviewScreen extends StatefulWidget {
  ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavourite = false;
  @override
  Widget build(BuildContext context) {
    // final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: const Text("🛒 Shop"),
          actions: [
            Consumer<Cart>(
              builder: (context, cartData, ch) => CustomBadge(
                child: ch!,
                value: cartData.itemCount.toString(),
                color: Colors.red,
              ),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: PopupMenuButton(
                // padding: EdgeInsets.all(10),
                onSelected: (FilterOptions value) {
                  setState(() {
                    if (value == FilterOptions.Favourite) {
                      _showOnlyFavourite = true;
                    } else {
                      _showOnlyFavourite = false;
                    }
                  });
                },
                child: const Icon(Icons.more_vert),
                itemBuilder: (_) => [
                  const PopupMenuItem(
                    value: FilterOptions.Favourite,
                    child: Text("Only Favourite"),
                  ),
                  const PopupMenuItem(
                    value: FilterOptions.All,
                    child: Text("Show All"),
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: ProductsGrid(_showOnlyFavourite));
  }
}
