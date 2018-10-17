import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String description;
  final double price;
  ProductPage(this.title, this.imageUrl, this.price, this.description);

  Widget _buildAddressPriceRow() {
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
          '\$' + price.toString(),
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
    return WillPopScope(
      onWillPop: () {
        print('Back Button Pressed');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: new Text(title),
        ),
        body: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(imageUrl),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TitleDefault(title),
              ),
              _buildAddressPriceRow(),
              Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  description,
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
      ),
    );
  }
}
