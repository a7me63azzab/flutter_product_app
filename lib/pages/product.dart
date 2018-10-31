import 'package:flutter/material.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_course/widgets/ui_elements/title_default.dart';
import 'package:flutter_course/scopped_models/main.dart';
import 'package:flutter_course/models/product.dart';

class ProductPage extends StatelessWidget {
  final int productIndex;
  ProductPage(this.productIndex);

  Widget _buildAddressPriceRow(Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Union Square, San Francisco',
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: Text(
            '|',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Text(
          '\$' + product.price.toString(),
          style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
        )
      ],
    );
  }

  _showWarningDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are You Sure ?'),
            content: Text('This action cann\'t be undone !'),
            actions: <Widget>[
              FlatButton(
                child: Text('DISCARED'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('CONTINUE'),
                onPressed: () {
                  Navigator.pop(context); // close dialog first
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () {
      print('Back Button Pressed');
      Navigator.pop(context, false);
      return Future.value(false);
    }, child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      final product = model.products[productIndex];
      return Scaffold(
        appBar: AppBar(
          title: new Text(product.title),
        ),
        body: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(product.image),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TitleDefault(product.title),
              ),
              _buildAddressPriceRow(product),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  product.description,
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10.0),
                  child: new RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: new Text('Delete'),
                    onPressed: () => _showWarningDialog(context),
                  )),
            ]),
      );
    }));
  }
}
