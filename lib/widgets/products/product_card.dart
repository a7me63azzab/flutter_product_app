import 'package:flutter/material.dart';
import './price_tag.dart';
import '../ui_elements/title_default.dart';
import '../products/address_tag.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final int productIndex;
  ProductCard(this.product, this.productIndex);

  Widget _buildTiltPriceRow() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault(product['title']),
          SizedBox(width: 8.0),
          PriceTag(product['price'].toString()),
        ],
      ),
    );
  }

  Widget _buildActionsButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).accentColor,
          onPressed: () => Navigator.pushNamed<bool>(
              context, '/product/' + productIndex.toString()),
        ),
        IconButton(
          color: Colors.red,
          icon: Icon(Icons.favorite_border),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: [
          Image.asset(product['image']),
          _buildTiltPriceRow(),
          AddressTag('Union Square, San Francisco'),
          _buildActionsButtons(context),
        ],
      ),
    );
  }
}
