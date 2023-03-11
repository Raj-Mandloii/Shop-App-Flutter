import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem with ChangeNotifier {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    print('++++++++++++++++++++++++++++++++++++++++++++++++++++++');
    try {
      final url = Uri.https('shop-app-service.onrender.com', 'orders/');
      final res = await http.get(url);
      print('================== BODY ================');
      print(json.decode(res.body));
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.https('shop-app-service.onrender.com', 'orders/create');
    final timeStamp = DateTime.now();
    try {
      final res = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'quantity': cp.quantity,
                    'price': cp.price
                  })
              .toList()
        }),
        headers: {"Content-Type": "application/json"},
      );
    } catch (e) {
      print(e);
      throw e;
    }

    _orders.insert(
      0,
      OrderItem(
        id: timeStamp.toString(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
