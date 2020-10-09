import 'dart:math';

import 'package:ecomm/model/product.dart';
import 'package:flutter/material.dart';

class CartManager with ChangeNotifier {
  List<Product> products = [];

  void addProduct(Product product) {
    var prod = products.firstWhere(
      (element) => product.id == element.id,
      orElse: () => null,
    );

    if (prod != null) {
      final newId = Random().nextInt(100).toString();
      product = Product.copyWithNewId(
        product,
        newId,
      );
    }

    products.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    products.removeWhere(
      (element) => element.id == product.id,
    );
    notifyListeners();
  }

  void removeAll() {
    products.clear();
    notifyListeners();
  }
  
}
