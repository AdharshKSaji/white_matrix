import 'package:flutter/material.dart';
import 'package:white_matrix/model/productmodel.dart';

class FavoriteController with ChangeNotifier {
  final List<ProductModel> _favorites = [];

  List<ProductModel> get favorites => _favorites;

  bool isExist(ProductModel product) {
    return _favorites.any((item) => item.title == product.title);
  }

  void toggleFavorite(ProductModel product) {
    if (isExist(product)) {
      _favorites.removeWhere((item) => item.title == product.title);
    } else {
      _favorites.add(product);
    }
    notifyListeners();
  }
}
