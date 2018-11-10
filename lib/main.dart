import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_course/pages/auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_course/scopped_models/main.dart';
import 'package:flutter_course/pages/products_admin.dart';
import 'package:flutter_course/pages/products.dart';
import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/pages/product.dart';
import 'package:map_view/map_view.dart';
import 'package:flutter_course/widgets/helpers/custom_route.dart';

void main() {
  // debugPaintSizeEnabled = true;
  MapView.setApiKey("AIzaSyDRuAzjz4dLpeQnvW4D8qZ7mX-G0pAZEcI");
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final MainModel _model = MainModel();
  bool _isAuthenticated = false;
  @override
  void initState() {
    _model.autoAuthenticate();
    _model.userSubject.listen((bool isAuthenticated) {
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: _model,
        child: MaterialApp(
          // debugShowMaterialGrid: true,
          title: 'Flutter Course',
          theme: ThemeData(
              primaryColor: Colors.deepOrange,
              accentColor: Colors.deepPurple,
              buttonColor: Colors.deepPurple),
          // home: AuthPage(),
          routes: {
            '/': (BuildContext context) =>
                !_isAuthenticated ? AuthPage() : ProductsPage(_model),
            '/admin': (BuildContext context) =>
                !_isAuthenticated ? AuthPage() : ProductsAdminPage(_model),
          },
          onGenerateRoute: (RouteSettings settings) {
            if (!_isAuthenticated) {
              MaterialPageRoute<bool>(
                builder: (BuildContext context) => AuthPage(),
              );
            }

            final List<String> pathElements = settings.name
                .split('/'); // route => /product/2 => ['product','2']
            if (pathElements[0] != '') {
              return null;
            }
            if (pathElements[1] == 'product') {
              final String productId = pathElements[2]; // index => 2
              // model.selectProduct(productId);
              final Product product =
                  _model.products.firstWhere((Product product) {
                return product.id == productId;
              });
              return CustomeRoute<bool>(
                builder: (BuildContext context) =>
                    !_isAuthenticated ? AuthPage() : ProductPage(product),
              );
            }
            return null;
          },
          onUnknownRoute: (RouteSettings settings) {
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  !_isAuthenticated ? AuthPage() : ProductsPage(_model),
            );
          },
        ));
  }
}
