import 'package:ecomm/model/product.dart';
import 'package:ecomm/provider/cart_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen(this.product);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final provider = Provider.of<CartManager>(
      context,
      listen: false,
    );
    return Scaffold(
      body: ProductLayout(
        deviceSize: deviceSize,
        product: product,
        provider: provider,
      ),
      appBar: AppBar(
        title: Text(
          product.name,
        ),
      ),
    );
  }
}

class ProductLayout extends StatelessWidget {
  const ProductLayout({
    Key key,
    @required this.deviceSize,
    @required this.product,
    @required this.provider,
  }) : super(key: key);

  final Size deviceSize;
  final Product product;
  final CartManager provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 50,
      ),
      height: (deviceSize.height -
          MediaQuery.of(context).padding.top -
          AppBar().preferredSize.height),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            child: Center(
              child: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            product.description,
          ),
          Spacer(),
          product.showAddToCart
              ? Container(
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
                      'Add to Cart',
                    ),
                    onPressed: () {
                      provider.addProduct(
                        product,
                      );
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(
                            milliseconds: 200,
                          ),
                          content: Text(
                            'Added to cart!',
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
