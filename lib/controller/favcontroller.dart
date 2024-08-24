// import 'package:flutter/material.dart';
// import 'package:white_matrix/model/productmodel.dart';

// import 'package:white_matrix/utiles/dbhelper.dart';

// class FavoriteController with ChangeNotifier {
//   final DatabaseHelper _databaseHelper = DatabaseHelper();

//   List<ProductModel> _favorites = [];
//   List<ProductModel> get favorites => _favorites;

//   FavoriteController() {
//     _loadFavorites();
//   }

//   Future<void> _loadFavorites() async {
//     _favorites = await _databaseHelper.getFavorites();
//     notifyListeners();
//   }

//   bool isExist(ProductModel product) {
//     return _favorites.any((item) => item.title == product.title);
//   }

//   Future<void> toggleFavorite(ProductModel product) async {
//     if (isExist(product)) {
//       await _databaseHelper.deleteFavorite(product.title as int);
//       _favorites.removeWhere((item) => item.title == product.title);
//     } else {
//       await _databaseHelper.insertFavorite(product);
//       _favorites.add(product);
//     }
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_matrix/model/productmodel.dart';

class FavoriteController extends ChangeNotifier {
  final List<ProductModel> _favoritesList = [];

  List<ProductModel> get favorites => _favoritesList;

  void toggleFavorite(ProductModel product) {
    if (_favoritesList.contains(product)) {
      _favoritesList.remove(product);
    } else {
      _favoritesList.add(product);
    }
    notifyListeners();
  }

  bool isExist(ProductModel product) {
    return _favoritesList.contains(product);
  }

  static FavoriteController of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<FavoriteController>(
      context,
      listen: listen,
    );
  }
}

