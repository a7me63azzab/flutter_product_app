import 'package:flutter/material.dart';
import '../widgets/products/products.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  ProductsPage(this.products);

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(automaticallyImplyLeading: false, title: Text('Choose')),
        ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            })
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: new AppBar(
        title: new Text('Easy List'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {},
          )
        ],
      ),
      body: Products(products),
    );
  }
}