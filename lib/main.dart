import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:flutter_course/pages/auth.dart';
import './pages/products_admin.dart';
import './pages/products.dart';
import './pages/product.dart';

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
  final List<Map<String, dynamic>> _products = [];

  void _addProduct(Map<String, dynamic> product) {
    setState(() {
      _products.add(product);
    });
  }

  void _updateProduct(int index, Map<String, dynamic> product) {
    setState(() {
      _products[index] = product;
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowMaterialGrid: true,
      title: 'Flutter Course',
      theme: ThemeData(
          primaryColor: Colors.deepOrange,
          accentColor: Colors.deepPurple,
          buttonColor: Colors.deepPurple),
      // home: AuthPage(),
      routes: {
        '/': (BuildContext context) => AuthPage(),
        '/products': (BuildContext context) => ProductsPage(_products),
        '/admin': (BuildContext context) =>
            ProductsAdminPage(_addProduct, _deleteProduct, _updateProduct, _products),
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements =
            settings.name.split('/'); // route => /product/2 => ['product','2']
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'product') {
          final int index = int.parse(pathElements[2]); // index => 2
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductPage(
                _products[index]['title'],
                _products[index]['image'],
                _products[index]['price'],
                _products[index]['description']),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<bool>(
          builder: (BuildContext context) => ProductsPage(_products),
        );
      },
    );
  }
}
