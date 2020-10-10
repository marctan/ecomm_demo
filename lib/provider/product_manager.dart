import 'dart:convert';

import 'package:flutter/material.dart';
import '../model/product.dart';
import 'package:http/http.dart' as http;

class ProductManager with ChangeNotifier {
  List<Product> products = [];
  List<Product> origProduct = [];

  void search(String query) {
    if (query.isNotEmpty) {
      List<Product> temporaryData = [];
      origProduct.forEach((element) {
        if (element.name.toLowerCase().contains(query.toLowerCase())) {
          temporaryData.add(element);
        }
        products.clear();
        products.addAll(temporaryData);
        notifyListeners();
      });
    } else {
      products.clear();
      products.addAll(
        origProduct,
      );
      notifyListeners();
    }
  }

  void fetchProducts() async {
    final url =
        'https://my-json-server.typicode.com/marctan/dummy_ecomm_data/products';

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final responseBody = response.body;
        List productsList = jsonDecode(responseBody);

        final productsFromJson = productsList
            .map((productJson) => Product.fromJson(productJson))
            .toList();

        origProduct.addAll(productsFromJson);
        products.addAll(productsFromJson);
        notifyListeners();
      }
    } catch (error) {
      print(error);
    }
  }
}
