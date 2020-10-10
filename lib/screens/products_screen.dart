import 'package:ecomm/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/product.dart';
import '../provider/product_manager.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductManager>(context, listen: false);
    provider.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductManager>(context);
    final deviceSize = MediaQuery.of(context).size;
    return provider.origProduct.length == 0
        ? Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/loadproducts.gif',
                  height: 100,
                  width: 100,
                ),
                Text(
                  'Fetching Products...',
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(
              top: 20,
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 20,
                  ),
                  width: deviceSize.width * 0.9,
                  child: TextField(
                    onChanged: (val) {
                      provider.search(val);
                    },
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    padding: EdgeInsets.all(
                      2,
                    ),
                    itemBuilder: (_, index) {
                      final product = provider.products[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) {
                                return ProductDetailScreen(
                                  product,
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(
                            10,
                          ),
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Hero(
                                  tag: product.id,
                                  child: FadeInImage.assetNetwork(
                                    fit: BoxFit.contain,
                                    placeholder: 'assets/load.gif',
                                    image: product.imageUrl,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange.withOpacity(
                                      0.8,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                      12.0,
                                    ),
                                    child: Text(
                                      product.name,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: provider.products.length,
                  ),
                ),
              ],
            ),
          );
  }
}
