import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';
import '../providers/orders.dart' show Orders;

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero).then(
        (_) => Provider.of<Orders>(context, listen: false).fetchAndSetOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Your Orders"),
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
          itemCount: orders.orders.length,
          itemBuilder: (context, i) => OrderItem(
                order: orders.orders[i],
              )),
    );
  }
}
