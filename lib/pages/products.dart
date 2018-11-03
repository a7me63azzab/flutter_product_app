import 'package:flutter/material.dart';
import 'package:flutter_course/widgets/products/products.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_course/scopped_models/main.dart';
import 'package:flutter_course/widgets/ui_elements/logout_list_tile.dart';

class ProductsPage extends StatefulWidget {
  final MainModel model;

  ProductsPage(this.model);

  @override
  State<StatefulWidget> createState() {
    return _ProductsPageState();
  }
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  initState() {
    widget.model.fetchProducts();
    super.initState();
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(children: [
        AppBar(automaticallyImplyLeading: false, title: Text('Choose')),
        ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            }),
        Divider(),
        LogoutListTile()
      ]),
    );
  }

  Widget _buildProductsList() {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      Widget content = Center(child: Text('No products found, plz add some.'));
      if (model.displayedProducts.length > 0 && !model.isLoading) {
        content = Products();
      } else if (model.isLoading) {
        content = Center(child: CircularProgressIndicator());
      }
      return RefreshIndicator(onRefresh: model.fetchProducts, child: content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: new AppBar(
        title: new Text('Easy List'),
        actions: <Widget>[
          ScopedModelDescendant<MainModel>(
              builder: (BuildContext context, Widget child, MainModel model) {
            return IconButton(
              icon: Icon(model.displayFavoritesOnly
                  ? Icons.favorite
                  : Icons.favorite_border),
              onPressed: () {
                model.toggleDisplayMode();
              },
            );
          })
        ],
      ),
      body: _buildProductsList(),
    );
  }
}
