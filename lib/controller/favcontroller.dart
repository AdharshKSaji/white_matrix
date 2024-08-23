import 'package:flutter/material.dart';
import 'package:white_matrix/model/productmodel.dart';

import 'package:white_matrix/utiles/dbhelper.dart';

class FavoriteController with ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<ProductModel> _favorites = [];
  List<ProductModel> get favorites => _favorites;

  FavoriteController() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _favorites = await _databaseHelper.getFavorites();
    notifyListeners();
  }

  bool isExist(ProductModel product) {
    return _favorites.any((item) => item.title == product.title);
  }

  Future<void> toggleFavorite(ProductModel product) async {
    if (isExist(product)) {
      await _databaseHelper.deleteFavorite(product.title as int);
      _favorites.removeWhere((item) => item.title == product.title);
    } else {
      await _databaseHelper.insertFavorite(product);
      _favorites.add(product);
    }
    notifyListeners();
  }
}
