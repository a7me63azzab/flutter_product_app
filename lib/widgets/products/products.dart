import 'package:flutter/material.dart';
import './product_card.dart';

class Products extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  Products(this.products);

  Widget _buildProductList() {
    Widget productCard = new Center(
      child: new Text('No products found, plz add some.'),
    );
    if (products.length > 0) {
      productCard = new ListView.builder(
        itemBuilder: (BuildContext context, index) =>
            ProductCard(products[index], index),
        itemCount: products.length,
      );
    }
    return productCard;
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}
