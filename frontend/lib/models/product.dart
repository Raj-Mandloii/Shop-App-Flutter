import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.imageUrl,
    this.isFavourite = false,
  });

  void toggleFavouriteStatus() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;

    final url = Uri.https('shop-app-service.onrender.com', 'product/$id');
    try {
      var res = await http.put(
        url,
        body: json.encode({
          'isFavourite': isFavourite,
        }),
        headers: {"Content-Type": "application/json"},
      );
      if(res.statusCode >= 400) {
        isFavourite = oldStatus;
        throw HttpException("Could not change status");
      }
      notifyListeners();
    } catch (e) {
      isFavourite = oldStatus;
    }
  }
}
