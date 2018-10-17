import 'package:flutter/material.dart';
import './product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;
  ProductListPage(this.products, this.updateProduct);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, index) {
        return ListTile(
          leading:
              Image.asset(products[index]['image'], width: 20.0, height: 20.0),
          title: Text(products[index]['title']),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return ProductEditPage(
                  product: products[index],
                  updateProduct: updateProduct,
                  productIndex: index,
                );
              }));
            },
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
