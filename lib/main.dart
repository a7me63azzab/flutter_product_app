import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_course/pages/auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_course/scopped_models/main.dart';
import 'package:flutter_course/pages/products_admin.dart';
import 'package:flutter_course/pages/products.dart';
import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/pages/product.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final MainModel model = MainModel();
    return ScopedModel<MainModel>(
        model: model,
        child: MaterialApp(
          // debugShowMaterialGrid: true,
          title: 'Flutter Course',
          theme: ThemeData(
              primaryColor: Colors.deepOrange,
              accentColor: Colors.deepPurple,
              buttonColor: Colors.deepPurple),
          // home: AuthPage(),
          routes: {
            '/': (BuildContext context) => AuthPage(),
            '/products': (BuildContext context) => ProductsPage(model),
            '/admin': (BuildContext context) => ProductsAdminPage(model),
          },
          onGenerateRoute: (RouteSettings settings) {
            final List<String> pathElements = settings.name
                .split('/'); // route => /product/2 => ['product','2']
            if (pathElements[0] != '') {
              return null;
            }
            if (pathElements[1] == 'product') {
              final String productId = pathElements[2]; // index => 2
              // model.selectProduct(productId);
              final Product product = model.products.firstWhere((Product product){
                return product.id == productId;
              });
              return MaterialPageRoute<bool>(
                builder: (BuildContext context) => ProductPage(product),
              );
            }
            return null;
          },
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductsPage(model),
            );
          },
        ));
  }
}
