import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_course/widgets/ui_elements/title_default.dart';
import 'package:flutter_course/widgets/products/product_fab.dart';
import 'package:flutter_course/models/product.dart';
import 'package:map_view/map_view.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  ProductPage(this.product);

  void _showMap() {
    final List<Marker> markers = <Marker>[
      Marker('position', 'position', product.location.latitude,
          product.location.longitude),
    ];
    final CameraPosition cameraPosition = CameraPosition(
        Location(product.location.latitude, product.location.longitude), 14.0);
    final MapView mapView = MapView();
    mapView.show(
      MapOptions(
          initialCameraPosition: cameraPosition,
          mapViewType: MapViewType.normal,
          title: 'Product Location'),
      toolbarActions: [ToolbarAction('Close', 1)],
    );
    mapView.onToolbarAction.listen((int id) {
      if (id == 1) {
        mapView.dismiss();
      }
    });

    mapView.onMapReady.listen((_) {
      mapView.setMarkers(markers);
    });
  }

  Widget _buildAddressPriceRow(Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: _showMap,
          child: Text(
            product.location.address.split(',')[0].toString(),
            style: TextStyle(fontFamily: 'Oswald', color: Colors.grey),
          ),
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

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          print('Back Button Pressed');
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
          // appBar: AppBar(
          //   title: new Text(product.title),
          // ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 265.0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: new Text(product.title),
                  background: Hero(
                    tag: product.id,
                    child: FadeInImage(
                      image: NetworkImage(product.image),
                      height: 300.0,
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/images/food.jpg'),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    alignment: Alignment.center,
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
                ]),
              )
            ],
          ),
          floatingActionButton: ProductFAB(product),
        ));
  }
}
