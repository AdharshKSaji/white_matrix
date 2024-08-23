import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final double price;

  Product({required this.id, required this.name, required this.price});
}

class CheckoutController extends ChangeNotifier {
  List<Product> cartItems = [];

  void addItemToCart(Product product) {
    cartItems.add(product);
    notifyListeners();
  }

  void removeItemFromCart(Product product) {
    cartItems.remove(product);
    notifyListeners();
  }

  double get totalAmount {
    return cartItems.fold<double>(0.0, (sum, item) => sum + item.price);
  }
}
