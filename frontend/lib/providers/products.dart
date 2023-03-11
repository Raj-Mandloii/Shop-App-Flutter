import 'package:flutter/material.dart';
import 'package:shop_app/models/http_exeptions.dart';
import '../models/product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // this is prifix.
// here ChangeNotifier is mixin class

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  // Get req
  fetchProduct() {
    final url = Uri.https('shop-app-service.onrender.com', 'product/');
    final res = http.get(url).then((res) {
      final extractedData = json.decode(res.body) as List<dynamic>;
      _items = [];
      extractedData.forEach((el) {
        _items.add(
          Product(
            id: el['_id'],
            title: el['title'],
            price: el['price'],
            description: el['description'],
            imageUrl: el['imageUrl'],
          ),
        );
      });
      notifyListeners();
    });
  }

  Future<void> addProduct(Product product) {
    final url = Uri.https('shop-app-service.onrender.com', 'product/create');
    return http.post(
      url,
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'price': product.price,
        'imageUrl': product.imageUrl,
        'isFavourite': product.isFavourite,
      }),
      headers: {"Content-Type": "application/json"},
    ).then((res) {
      // print(json.decode(res.body));
      final newProduct = Product(
          id: product.title,
          title: product.title,
          price: product.price,
          description: product.description,
          imageUrl: product.imageUrl);

      // _items.add(newProduct); // to add at the end.
      _items.insert(0, newProduct); // to add prod at the beginning.

      notifyListeners();
    }).catchError((e) {
      throw e;
    });
  }

  void updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      print(
          '================================================================$id');
      final url = Uri.https('shop-app-service.onrender.com', 'product/$id');
      var res = await http.put(
        url,
        body: json.encode({
          'title': newProduct.title,
          'price': newProduct.price,
          'description': newProduct.description,
          'imageUrl': newProduct.imageUrl,
          'isFavourite': false,
        }),
        headers: {"Content-Type": "application/json"},
      );
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {}
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.https('shop-app-service.onrender.com', 'product/$id');
    final existingProdIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProd = _items[existingProdIndex];
    _items.removeAt(existingProdIndex);
    notifyListeners();

    final res = await http.delete(url);
    if (res.statusCode >= 400) {
      _items.insert(existingProdIndex, existingProd);
      notifyListeners();
      throw HttpExeption('Could not delete product');
    }
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
