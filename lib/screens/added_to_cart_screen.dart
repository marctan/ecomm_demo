import 'package:ecomm/provider/cart_manager.dart';
import 'package:ecomm/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final provider = Provider.of<CartManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Added to Cart',
        ),
      ),
      body: provider.products.length == 0
          ? Center(
              child: Container(
                width: 100,
                height: 100,
                child: Image.asset(
                  "assets/emptycart.png",
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.all(
                      5,
                    ),
                    itemBuilder: (_, index) {
                      final product = provider.products[index];
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        onTap: () {
                          product.showAddToCart = false;
                          return Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return ProductDetailScreen(
                                  product,
                                );
                              },
                            ),
                          ).then(
                            (value) {
                              product.showAddToCart = true;
                            },
                          );
                        },
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            provider.removeProduct(
                              product,
                            );
                          },
                        ),
                        leading: Container(
                          width: 100,
                          child: Image.network(
                            product.imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                        title: Text(
                          product.name,
                        ),
                      );
                    },
                    separatorBuilder: (_, __) {
                      return Divider(
                        color: Colors.black,
                        thickness: 1,
                      );
                    },
                    itemCount: provider.products.length,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: 50,
                  ),
                  width: deviceSize.width * .5,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    padding: EdgeInsets.all(
                      20,
                    ),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Remove all from cart',
                    ),
                    onPressed: () {
                      provider.removeAll();
                    },
                  ),
                )
              ],
            ),
    );
  }
}
