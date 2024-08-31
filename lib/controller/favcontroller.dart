

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

