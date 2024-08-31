
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:white_matrix/model/productmodel.dart';

class BookingController extends ChangeNotifier {
  final List<ProductModel> favorateslist = [];
  List<ProductModel> get favorites => favorateslist;

  void toggleFavorite(ProductModel product) {
    if (favorateslist.contains(product)) {
      favorateslist.remove(product);
    } else {
      favorateslist.add(product);
    }
    notifyListeners();
  }

  bool isExist(ProductModel product) {
    return favorateslist.contains(product);
  }

  double totalPrice() {
    return favorateslist.fold(0.0, (sum, item) => sum + item.originalPrice);
  }

  static BookingController of(
    BuildContext context, {
    bool listen = true,
  }) {
    return Provider.of<BookingController>(
      context,
      listen: listen,
    );
  }
}
