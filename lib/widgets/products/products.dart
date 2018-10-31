import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_course/scopped_models/main.dart';
import 'package:flutter_course/widgets/products/product_card.dart';
import 'package:flutter_course/models/product.dart';

class Products extends StatelessWidget {
  Widget _buildProductList(List<Product> products) {
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
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return _buildProductList(model.displayedProducts);
    });
  }
}
