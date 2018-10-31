import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_course/models/product.dart';
import 'package:flutter_course/models/user.dart';

class ConnectedProductsModel extends Model {
  final List<Product> _products = [];
  User _authenticatedUser;
}

class ProductsModel extends ConnectedProductsModel {
  int _selectedProductIndex;
  bool _showFavorites = false;

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if (_showFavorites) {
      return _products.where((Product product) => product.isFavorite).toList();
    }
    return List.from(_products);
  }

  bool get displayFavoritesOnly {
    return _showFavorites;
  }

  int get selectedProductindex {
    return _selectedProductIndex;
  }

  Product get selectedProduct {
    if (_selectedProductIndex == null) {
      return null;
    }
    return _products[_selectedProductIndex];
  }

  // void addProduct(Product product) {
  //   _products.add(product);
  //   _selectedProductIndex = null;
  //   notifyListeners();
  // }

  void addProduct(
      String title, String description, String image, double price) {
    final Product newProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userEmail: _authenticatedUser.email,
        userId: _authenticatedUser.id);
    _products.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String title, String description, String image,
      double price, bool isFavorite) {
    final Product updatedProduct = Product(
        title: title,
        description: description,
        image: image,
        price: price,
        isFavorite: isFavorite,
        userEmail: selectedProduct.userEmail,
        userId: selectedProduct.userId);
    _products[_selectedProductIndex] = updatedProduct;
    // _selectedProductIndex = null;
    notifyListeners();
  }

  void toggleProductFavoriteStatus() {
    final isCurrentFavorite = selectedProduct.isFavorite;
    final bool newFavoriteStatus = !isCurrentFavorite;
    updateProduct(selectedProduct.title, selectedProduct.description,
        selectedProduct.image, selectedProduct.price, newFavoriteStatus);
    notifyListeners();
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    // _selectedProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}

class UserModel extends ConnectedProductsModel {
  void login(String email, String password) {
    _authenticatedUser = User(id: '1234', email: email, password: password);
  }
}
