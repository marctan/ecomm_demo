import 'package:flutter/material.dart';

import '../constants/dummy_products.dart';
import '../constants/dummy_products.dart';
import '../constants/dummy_products.dart';
import '../constants/dummy_products.dart';
import '../constants/dummy_products.dart';
import '../constants/dummy_products.dart';
import '../model/product.dart';

class ProductManager with ChangeNotifier {
  List<Product> products = [...DUMMY_PRODUCTS];

  void search(String query) {
    if (query.isNotEmpty) {
      List<Product> temporaryData = [];
      DUMMY_PRODUCTS.forEach((element) {
        if (element.name.contains(query)) {
          temporaryData.add(element);
        }
        products.clear();
        products.addAll(temporaryData);
        notifyListeners();
      });
    } else {
      products.clear();
      products.addAll(
        [...DUMMY_PRODUCTS],
      );
      notifyListeners();
    }
  }
}
