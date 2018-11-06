import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_course/scopped_models/main.dart';
import 'package:flutter_course/widgets/products/price_tag.dart';
import 'package:flutter_course/widgets/ui_elements/title_default.dart';
import 'package:flutter_course/widgets/products/address_tag.dart';
import 'package:flutter_course/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;
  ProductCard(this.product, this.productIndex);

  Widget _buildTiltPriceRow() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TitleDefault(product.title),
          SizedBox(width: 8.0),
          PriceTag(product.price.toString()),
        ],
      ),
    );
  }

  Widget _buildActionsButtons(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.info),
            color: Theme.of(context).accentColor,
            onPressed: () => Navigator.pushNamed<bool>(
                context, '/product/' + model.products[productIndex].id),
          ),
          IconButton(
            color: Colors.red,
            icon: Icon(model.products[productIndex].isFavorite
                ? Icons.favorite
                : Icons.favorite_border),
            onPressed: () {
              model.selectProduct(model.products[productIndex].id);
              model.toggleProductFavoriteStatus();
            },
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      child: new Column(
        children: [
          FadeInImage(
            image: NetworkImage(product.image),
            height: 300.0,
            fit: BoxFit.cover,
            placeholder: AssetImage('assets/images/food.jpg'),
          ),
          _buildTiltPriceRow(),
          AddressTag(product.location.address),
          _buildActionsButtons(context),
        ],
      ),
    );
  }
}
