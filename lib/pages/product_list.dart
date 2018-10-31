import 'package:flutter/material.dart';
import 'package:flutter_course/pages/product_edit.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_course/scopped_models/main.dart';
// import '../models/product.dart';

class ProductListPage extends StatelessWidget {
  Widget _buildEditButton(
      BuildContext context, int index, MainModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(index);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (BuildContext context) {
          return ProductEditPage();
        }));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, index) {
            return Dismissible(
                key: Key(model.products[index].title),
                onDismissed: (DismissDirection direction) {
                  if (direction == DismissDirection.endToStart) {
                    model.selectProduct(index);
                    model.deleteProduct();
                  }
                },
                background: Container(color: Colors.red),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                          backgroundImage:
                              AssetImage(model.products[index].image)),
                      title: Text(model.products[index].title),
                      subtitle:
                          Text('\$${model.products[index].price.toString()}'),
                      trailing: _buildEditButton(context, index, model),
                    ),
                    Divider(),
                  ],
                ));
          },
          itemCount: model.products.length,
        );
      },
    );
  }
}
