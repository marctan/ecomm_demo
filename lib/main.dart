import 'package:badges/badges.dart';
import 'package:ecomm/provider/cart_manager.dart';
import 'package:ecomm/screens/added_to_cart_screen.dart';
import 'package:ecomm/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/product_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartManager(),
        )
      ],
      child: MaterialApp(
        home: Home(),
        theme: ThemeData(
          primaryColor: Colors.orange,
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductsScreen(),
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return CartScreen();
                  },
                ),
              );
            },
            child: Consumer<CartManager>(
              builder: (_, productManager, __) {
                return Container(
                  margin: EdgeInsets.only(
                    right: 20,
                    left: 20,
                    top: 5,
                  ),
                  child: Badge(
                    badgeContent: Text(
                      productManager.products.length.toString(),
                    ),
                    child: Icon(
                      Icons.shopping_cart_outlined,
                    ),
                  ),
                );
              },
            ),
          )
        ],
        title: Text(
          'Products',
        ),
      ),
    );
  }
}
