import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/screens/edit_product.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';
import './providers/orders.dart';
import './screens/CartScreen.dart';
import './providers/cart.dart';
import './providers/products.dart';
import './screens/product_detail_screen.dart';
import './screens/product_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '🛒 Shop App',
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.deepOrange,
            fontFamily: "Lato"),
        home: ProductOverviewScreen(),
        routes: {
          ProductDetail.routeName: (ctx) => ProductDetail(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrdersScreen.routeName: (ctx) => const OrdersScreen(),
          UserProductScreen.routeName: (ctx) => const UserProductScreen(),
          EditProduct.routeName: (ctx) => const EditProduct(),
        },
      ),
    );
  }
}

//192.168.116.201/
// 1031