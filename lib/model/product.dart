class Product {
  String id;
  String name;
  String description;
  String imageUrl;
  bool showAddToCart = true;

  Product(
    this.id,
    this.name,
    this.description,
    this.imageUrl,
  );

  factory Product.copyWithNewId(Product prod, String newId) {
    return Product(
      newId,
      prod.name,
      prod.description,
      prod.imageUrl,
    );
  }
}
