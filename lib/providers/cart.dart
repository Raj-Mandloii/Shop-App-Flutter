import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity * cartItem.price;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
   
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (exists) => CartItem(
              id: exists.id,
              title: exists.title,
              price: exists.price,
              quantity: exists.quantity + 1));
      //.. Change quantity
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
     
    notifyListeners();
  }
  void removeItem(String productId){
    print(_items);
       _items.remove(productId);
       notifyListeners();
  }

  void clearCart(){
    _items = {};
    notifyListeners();
  }
}
